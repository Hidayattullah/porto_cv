import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../model/history/history_model.dart';

class HistoryDataSource {
  final FirebaseFirestore _firestore;

  HistoryDataSource(this._firestore);

  Future<void> addHistory(HistoryModel history) async {
    try {
      await _firestore.collection('history_apply').add(history.toMap());
      if (kDebugMode) {
        print("History added successfully.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error adding history: $e");
      }
      throw Exception("Failed to add history");
    }
  }

  Future<List<HistoryModel>> getHistory() async {
    try {
      if (kDebugMode) {
        print("Fetching histories from Firestore...");
      }
      final querySnapshot = await _firestore.collection('history_apply').get();
      final histories = querySnapshot.docs
          .map((doc) => HistoryModel.fromMap(doc.data(), doc.id))
          .toList();
      if (kDebugMode) {
        print("Histories fetched successfully. Total: ${histories.length}");
      }
      return histories;
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching histories from Firestore: $e');
      }
      throw Exception("Failed to fetch histories");
    }
  }

  Future<void> updateHistory(HistoryModel history) async {
    try {
      await _firestore.collection('history_apply').doc(history.id).update(history.toMap());
      if (kDebugMode) {
        print("History updated successfully.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error updating history: $e");
      }
      throw Exception("Failed to update history");
    }
  }

  Future<void> deleteHistory(String id) async {
    try {
      await _firestore.collection('history_apply').doc(id).delete();
      if (kDebugMode) {
        print("History deleted successfully.");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting history: $e");
      }
      throw Exception("Failed to delete history");
    }
  }
}
