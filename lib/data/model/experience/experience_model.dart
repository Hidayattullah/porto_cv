// File: lib/data/models/experience/experience_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/experience_entity.dart';

class ExperienceModel extends ExperienceEntity {
  ExperienceModel({
    required super.id,
    required super.title,
    required super.company,
    required super.startDate,
    super.endDate,
    required super.description,
    super.tags,
  });

  factory ExperienceModel.fromMap(Map<String, dynamic> map, String id) {
    return ExperienceModel(
      id: id,
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: map['endDate'] != null ? (map['endDate'] as Timestamp).toDate() : null,
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
