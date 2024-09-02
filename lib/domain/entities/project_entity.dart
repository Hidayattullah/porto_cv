// File: domain/entities/project_entity.dart
class ProjectEntity {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final bool isCompleted;

  ProjectEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.isCompleted,
  });
}
