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

  // Tambahkan metode copyWith
  ExperienceEntity copyWith({
    String? id,
    String? title,
    String? company,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
    List<String>? tags,
  }) {
    return ExperienceEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      company: company ?? this.company,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      tags: tags ?? this.tags,
    );
  }
}
