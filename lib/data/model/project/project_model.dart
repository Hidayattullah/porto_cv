// File: data/models/project_model.dart
import '../../../domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  ProjectModel({
    required super.id,
    required super.title,
    required super.description,
    required super.yearMade,
    required super.builtWith,
    required super.madeAt,
    required super.link,
  });

  // Method untuk mengubah data dari Firestore menjadi ProjectModel
  factory ProjectModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ProjectModel(
      id: documentId,
      title: map['title'],
      description: map['description'],
      yearMade: map['yearMade'],
      builtWith: map['builtWith'],
      madeAt: map['madeAt'],
      link: map['link'],
    );
  }

  // Method untuk mengubah ProjectModel menjadi map sebelum disimpan ke Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'yearMade': yearMade,
      'builtWith': builtWith,
      'madeAt': madeAt,
      'link': link,
    };
  }
}
