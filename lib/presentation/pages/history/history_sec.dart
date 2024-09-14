import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/history/history_cubit.dart';
import 'history_form.dart';
import 'history_body.dart';

class HistorySec extends StatelessWidget {
  const HistorySec({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => HistoryForm(
                  onAddHistory: (newHistory) {
                    context.read<HistoryCubit>().addHistory;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('History added successfully.'),
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: const HistoryBody(),
    );
  }
}
