
import '../../../domain/entities/experience_entity.dart';

class ExperienceModel extends ExperienceEntity {
  ExperienceModel({
    required super.id,
    required super.title,
    required super.company,
    required super.startDate,
    required super.endDate,
    required super.description,
    super.tags,
  });

  factory ExperienceModel.fromMap(Map<String, dynamic> map, String id) {
    return ExperienceModel(
      id: id,
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      description: map['description'] ?? '',
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'company': company,
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
      'tags': tags,
    };
  }
}
