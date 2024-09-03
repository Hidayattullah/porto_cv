// File: lib/data/models/repositories/experience_repository_impl.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart'; // Untuk kDebugMode
import '../../../domain/entities/experience_entity.dart';
import '../../domain/repositores/experience_repository.dart';

class ExperienceRepositoryImpl implements ExperienceRepository {
  final FirebaseFirestore _firestore;

  ExperienceRepositoryImpl(this._firestore);

  @override
  Future<void> addExperience(ExperienceEntity experience) async {
    if (kDebugMode) {
      print('Adding experience: ${experience.title}');
    }
    try {
      await _firestore.collection('experiences').add({
        'title': experience.title,
        'company': experience.company,
        'startDate': experience.startDate.toIso8601String(),
        'endDate': experience.endDate?.toIso8601String(),
        'description': experience.description,
        'tags': experience.tags,
      });
      if (kDebugMode) {
        print('Experience added successfully: ${experience.title}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding experience: $e');
      }
      rethrow; // Optional: rethrow to let the error propagate
    }
  }

  @override
  Future<void> updateExperience(ExperienceEntity experience) async {
    if (kDebugMode) {
      print('Updating experience: ${experience.title}');
    }
    try {
      await _firestore.collection('experiences').doc(experience.id).update({
        'title': experience.title,
        'company': experience.company,
        'startDate': experience.startDate.toIso8601String(),
        'endDate': experience.endDate?.toIso8601String(),
        'description': experience.description,
        'tags': experience.tags,
      });
      if (kDebugMode) {
        print('Experience updated successfully: ${experience.title}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating experience: $e');
      }
      rethrow;
    }
  }

  @override
  Future<void> deleteExperience(String experienceId) async {
    if (kDebugMode) {
      print('Deleting experience: $experienceId');
    }
    try {
      await _firestore.collection('experiences').doc(experienceId).delete();
      if (kDebugMode) {
        print('Experience deleted successfully: $experienceId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting experience: $e');
      }
      rethrow;
    }
  }

  @override
  Future<List<ExperienceEntity>> getExperiences() async {
    if (kDebugMode) {
      print('Fetching experiences...');
    }
    try {
      final querySnapshot = await _firestore.collection('experiences').get();
      final experiences = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return ExperienceEntity(
          id: doc.id,
          title: data['title'],
          company: data['company'],
          startDate: DateTime.parse(data['startDate']),
          endDate: DateTime.parse(data['endDate']),
          description: data['description'],
          tags: List<String>.from(data['tags']),
        );
      }).toList();
      if (kDebugMode) {
        print('Experiences fetched successfully. Total: ${experiences.length}');
      }
      return experiences;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching experiences: $e');
      }
      rethrow;
    }
  }
}
