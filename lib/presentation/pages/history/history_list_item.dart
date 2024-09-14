import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../domain/entities/history_entitiy.dart';
import '../../cubits/history/history_cubit.dart';
import 'history_update.dart';

class HistoryListItem extends StatefulWidget {
  final HistoryEntity history;

  const HistoryListItem({required this.history, super.key});

  @override
  _HistoryListItemState createState() => _HistoryListItemState();
}

class _HistoryListItemState extends State<HistoryListItem> {
  bool _isHovering = false;

  // Method to launch the URL
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        _isHovering = true;
      }),
      onExit: (_) => setState(() {
        _isHovering = false;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: _isHovering ? Colors.white : Colors.grey[100], // Background color change on hover
          borderRadius: BorderRadius.circular(5),
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.6), // Shadow effect on hover
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: ListTile(
          onTap: () {
            _launchURL(widget.history.link); // Open the link in the browser
          },
          title: Text(
            widget.history.companyName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          subtitle: Text(
            'Job Title: ${widget.history.jobTitle}\n'
            'Apply Date: ${widget.history.applyDate.toLocal().toString().split(' ')[0]}\n'
            'Status: ${widget.history.status}',
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => HistoryUpdate(history: widget.history),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  context.read<HistoryCubit>().deleteHistoryById(widget.history.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${widget.history.companyName} deleted successfully.'),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
