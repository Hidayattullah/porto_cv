import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../cubits/navigation/navigation_cubit.dart';
import '../widgets/navigation/desktop_sec.dart';
import '../widgets/navigation/mobile_sec.dart';
import 'experience/experience_body.dart';
import 'content/contact_sec.dart';
import 'content/home_sec.dart';
import 'content/project_sec.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  // Variabel untuk menyimpan state saat ini
  NavigationState _currentNavigationState = NavigationState.homesec;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      itemPositionsListener.itemPositions.addListener(() {
        final positions = itemPositionsListener.itemPositions.value;
        if (positions.isNotEmpty) {
          final firstVisibleItemIndex = positions
              .where((ItemPosition position) => position.itemLeadingEdge >= 0)
              .reduce((ItemPosition min, ItemPosition position) => position.itemLeadingEdge < min.itemLeadingEdge ? position : min)
              .index;

          // Menggunakan NavigationCubit untuk navigasi berdasarkan scroll
          switch (firstVisibleItemIndex) {
            case 0:
              if (_currentNavigationState != NavigationState.homesec) {
                _currentNavigationState = NavigationState.homesec;
                BlocProvider.of<NavigationCubit>(context).navigateToshowHomeSec();
              }
              break;
            case 1:
              if (_currentNavigationState != NavigationState.experiencesec) {
                _currentNavigationState = NavigationState.experiencesec;
                BlocProvider.of<NavigationCubit>(context).navigateToshowExperienceSec();
              }
              break;
            case 2:
              if (_currentNavigationState != NavigationState.projectsec) {
                _currentNavigationState = NavigationState.projectsec;
                BlocProvider.of<NavigationCubit>(context).navigateToshowProjectSec();
              }
              break;
            case 3:
              if (_currentNavigationState != NavigationState.contactsec) {
                _currentNavigationState = NavigationState.contactsec;
                BlocProvider.of<NavigationCubit>(context).navigateToshowContactSec();
              }
              break;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktopMode = MediaQuery.of(context).size.width >= 1024;
    return Scaffold(
      body: BlocListener<NavigationCubit, NavigationState>(
        listener: (context, state) {
          if (_currentNavigationState != state) {
            _currentNavigationState = state;
            final index = state.index;
            itemScrollController.scrollTo(
              index: index,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
            );
          }
        },
        child: isDesktopMode
            ? Row(
                children: [
                  const DesktopSec(), // Side navigation untuk desktop
                  Expanded(child: _buildScrollableContent()),
                ],
              )
            : const MobileSec(), // SliverPersistentHeader untuk mobile dan tablet
      ),
    );
  }

  Widget _buildScrollableContent() {
    return ScrollablePositionedList.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: _getSectionWidget(index),
        );
      },
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
    );
  }

  Widget _getSectionWidget(int index) {
    switch (index) {
      case 0:
        return const HomeSec();
      case 1:
        return const ExperienceSec();
      case 2:
        return const ProjectSec();
      case 3:
        return const ContactSec();
      default:
        return const HomeSec();
    }
  }
}

extension NavigationStateExtension on NavigationState {
  int get index {
    switch (this) {
      case NavigationState.homesec:
        return 0;
      case NavigationState.experiencesec:
        return 1;
      case NavigationState.projectsec:
        return 2;
      case NavigationState.contactsec:
        return 3;
      default:
        return 0;
    }
  }
}
