import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/history_entitiy.dart';
import '../../cubits/history/history_cubit.dart';
import 'history_update.dart';

class HistoryListItem extends StatelessWidget {
  final HistoryEntity history;

  const HistoryListItem({required this.history, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: ListTile(
        title: Text(
          history.companyName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Job Title: ${history.jobTitle}\nApply Date: ${history.applyDate.toLocal().toString().split(' ')[0]}\nStatus: ${history.status}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => HistoryUpdate(history: history),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context.read<HistoryCubit>().deleteHistory;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${history.companyName} deleted successfully.'),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
