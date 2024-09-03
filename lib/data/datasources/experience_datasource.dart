// File: lib/data/models/datasources/experience_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/experience/experience_model.dart';

class ExperienceDataSource {
  final FirebaseFirestore _firestore;

  ExperienceDataSource(this._firestore);

  Future<void> addExperience(ExperienceModel experience) async {
    await _firestore.collection('experiences').add(experience.toMap());
  }

  Future<void> updateExperience(ExperienceModel experience) async {
    await _firestore.collection('experiences').doc(experience.id).update(experience.toMap());
  }

  Future<void> deleteExperience(String experienceId) async {
    await _firestore.collection('experiences').doc(experienceId).delete();
  }

  Future<List<ExperienceModel>> getExperiences() async {
    final querySnapshot = await _firestore.collection('experiences').get();
    return querySnapshot.docs.map((doc) {
      return ExperienceModel.fromMap(doc.data(), doc.id);
    }).toList();
  }
}
