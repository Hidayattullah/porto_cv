// data/datasources/history_datasource.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/history/history_model.dart';

abstract class HistoryDataSource {
  Future<void> addHistory(HistoryModel history);
  Future<List<HistoryModel>> getHistories();
  Future<void> updateHistory(HistoryModel history);
  Future<void> deleteHistory(String id);
}

class HistoryDataSourceImpl implements HistoryDataSource {
  final FirebaseFirestore firestore;

  HistoryDataSourceImpl(this.firestore);

  @override
  Future<void> addHistory(HistoryModel history) async {
    await firestore.collection('history_apply').doc(history.id).set(history.toJson());
  }

  @override
  Future<List<HistoryModel>> getHistories() async {
    final querySnapshot = await firestore.collection('history_apply').get();
    return querySnapshot.docs.map((doc) => HistoryModel.fromJson(doc.data())).toList();
  }

  @override
  Future<void> updateHistory(HistoryModel history) async {
    await firestore.collection('history_apply').doc(history.id).update(history.toJson());
  }

  @override
  Future<void> deleteHistory(String id) async {
    await firestore.collection('history_apply').doc(id).delete();
  }
}
