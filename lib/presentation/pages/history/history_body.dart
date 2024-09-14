import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/history/history_cubit.dart';
import '../../cubits/history/history_state.dart';
import 'history_list_item.dart';

class HistoryBody extends StatelessWidget {
  const HistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        if (state is HistoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HistoryLoaded) {
          final histories = state.histories;
          if (histories.isEmpty) {
            return const Center(child: Text('No history records found.'));
          }
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: histories.map((history) {
                  return HistoryListItem(history: history);
                }).toList(),
              ),
            ),
          );
        } else if (state is HistoryError) {
          return Center(
            child: Text(state.message),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
