// File: data/datasources/project_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/project/project_model.dart';

class ProjectDataSource {
  final FirebaseFirestore _firestore;

  ProjectDataSource(this._firestore);

  Future<void> addProject(ProjectModel project) async {
    await _firestore.collection('projects').add(project.toMap());
  }

  Future<void> updateProject(ProjectModel project) async {
    await _firestore.collection('projects').doc(project.id).update(project.toMap());
  }

  Future<void> deleteProject(String projectId) async {
    await _firestore.collection('projects').doc(projectId).delete();
  }

  Future<List<ProjectModel>> getProjects() async {
    final querySnapshot = await _firestore.collection('projects').get();
    return querySnapshot.docs.map((doc) {
      return ProjectModel.fromMap(doc.data(), doc.id);
    }).toList();
  }
}
