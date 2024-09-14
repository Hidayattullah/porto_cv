import '../../../domain/entities/history_entitiy.dart';

class HistoryModel extends HistoryEntity {
  const HistoryModel({
    required super.id,
    required super.companyName,
    required super.jobTitle,
    required super.applyDate,
    required super.source,
    required super.status,
    required super.link,
  });

  factory HistoryModel.fromMap(Map<String, dynamic> map, String documentId) {
    return HistoryModel(
      id: documentId,
      companyName: map['companyName'],
      jobTitle: map['jobTitle'],
      applyDate: DateTime.parse(map['applyDate']),
      source: map['source'],
      status: map['status'],
      link: map['link'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'jobTitle': jobTitle,
      'applyDate': applyDate.toIso8601String(),
      'source': source,
      'status': status,
      'link': link,
    };
  }
}
