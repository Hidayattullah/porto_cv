import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/history/history_cubit.dart';
import 'history_body.dart';
import 'history_form.dart'; // Menggunakan HistoryBody

class HistorySec extends StatefulWidget {
  const HistorySec({super.key});

  @override
  _HistorySecState createState() => _HistorySecState();
}

class _HistorySecState extends State<HistorySec> {
  @override
  void initState() {
    super.initState();
    
    // Memanggil Cubit untuk mengambil daftar history
    context.read<HistoryCubit>().fetchHistories();
  }

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
                    context.read<HistoryCubit>().addNewHistory(newHistory);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: const HistoryBody(), // Menggunakan HistoryBody di sini
    );
  }
}
