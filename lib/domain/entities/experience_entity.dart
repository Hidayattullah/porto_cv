// File: lib/domain/entities/experience_entity.dart
class ExperienceEntity {
  final String id;
  final String title;
  final String company;
  final DateTime startDate;
  final DateTime? endDate;
  final String description;
  final List<String>? tags;

  ExperienceEntity({
    required this.id,
    required this.title,
    required this.company,
    required this.startDate,
    this.endDate,
    required this.description,
    this.tags,
  });
}
