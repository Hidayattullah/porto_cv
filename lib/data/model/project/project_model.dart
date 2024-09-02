// File: data/models/project_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  ProjectModel({
    required super.id,
    required super.title,
    required super.description,
    required super.startDate,
    required super.endDate,
    required super.isCompleted,
  });

  // Method untuk mengubah data dari Firestore menjadi ProjectModel
  factory ProjectModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ProjectModel(
      id: documentId,
      title: map['title'],
      description: map['description'],
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: (map['endDate'] as Timestamp).toDate(),
      isCompleted: map['isCompleted'],
    );
  }

  // Method untuk mengubah ProjectModel menjadi map sebelum disimpan ke Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'isCompleted': isCompleted,
    };
  }
}
