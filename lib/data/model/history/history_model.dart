// data/models/history_model.dart
import '../../../domain/entities/history_entitiy.dart';

class HistoryModel extends HistoryEntity {
  const HistoryModel({
    required super.id,
    required super.companyName,
    required super.jobTitle,
    required super.applyDate,
    required super.source,
    required super.status,
    super.notes,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'],
      companyName: json['companyName'],
      jobTitle: json['jobTitle'],
      applyDate: DateTime.parse(json['applyDate']),
      source: json['source'],
      status: json['status'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyName': companyName,
      'jobTitle': jobTitle,
      'applyDate': applyDate.toIso8601String(),
      'source': source,
      'status': status,
      'notes': notes,
    };
  }
}
