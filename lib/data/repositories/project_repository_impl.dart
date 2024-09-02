// File: data/repositories/project_repository_impl.dart
import 'package:cloud_firestore/cloud_firestore.dart'; // Jika menggunakan Firebase
import 'package:flutter/foundation.dart'; // Untuk kDebugMode
import '../../domain/entities/project_entity.dart';
import '../../domain/repositores/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final FirebaseFirestore _firestore;

  ProjectRepositoryImpl(this._firestore);

  @override
  Future<void> addProject(ProjectEntity project) async {
    if (kDebugMode) {
      print('Adding project: ${project.title}');
    }
    try {
      await _firestore.collection('projects').add({
        'id': project.id,
        'title': project.title,
        'description': project.description,
        'startDate': project.startDate.toIso8601String(),
        'endDate': project.endDate.toIso8601String(),
        'isCompleted': project.isCompleted,
      });
      if (kDebugMode) {
        print('Project added successfully: ${project.title}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding project: $e');
      }
      rethrow; // Optional: rethrow to let the error propagate
    }
  }

  @override
  Future<void> updateProject(ProjectEntity project) async {
    if (kDebugMode) {
      print('Updating project: ${project.title}');
    }
    try {
      await _firestore.collection('projects').doc(project.id).update({
        'title': project.title,
        'description': project.description,
        'startDate': project.startDate.toIso8601String(),
        'endDate': project.endDate.toIso8601String(),
        'isCompleted': project.isCompleted,
      });
      if (kDebugMode) {
        print('Project updated successfully: ${project.title}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating project: $e');
      }
      rethrow;
    }
  }

  @override
  Future<void> deleteProject(String projectId) async {
    if (kDebugMode) {
      print('Deleting project: $projectId');
    }
    try {
      await _firestore.collection('projects').doc(projectId).delete();
      if (kDebugMode) {
        print('Project deleted successfully: $projectId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting project: $e');
      }
      rethrow;
    }
  }

  @override
  Future<List<ProjectEntity>> getProjects() async {
    if (kDebugMode) {
      print('Fetching projects...');
    }
    try {
      final querySnapshot = await _firestore.collection('projects').get();
      final projects = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return ProjectEntity(
          id: doc.id,
          title: data['title'],
          description: data['description'],
          startDate: DateTime.parse(data['startDate']),
          endDate: DateTime.parse(data['endDate']),
          isCompleted: data['isCompleted'],
        );
      }).toList();
      if (kDebugMode) {
        print('Projects fetched successfully. Total: ${projects.length}');
      }
      return projects;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching projects: $e');
      }
      rethrow;
    }
  }
}
