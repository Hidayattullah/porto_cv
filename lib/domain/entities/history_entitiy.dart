class HistoryEntity {
  final String id;
  final String companyName;
  final String jobTitle;
  final DateTime applyDate;
  final String source;
  final String status;
  final String link;

  const HistoryEntity({
    required this.id,
    required this.companyName,
    required this.jobTitle,
    required this.applyDate,
    required this.source,
    required this.status,
    required this.link,
  });
}
