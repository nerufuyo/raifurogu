import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raifurogu/data/models/data_model.dart';

class FirestoreService {
  final CollectionReference _dataCollection =
      FirebaseFirestore.instance.collection('data');

  Future<void> addData(DataModel data) async {
    await _dataCollection.add(data.toFirestore());
  }

  Future<void> updateData(String id, DataModel data) async {
    await _dataCollection.doc(id).update(data.toFirestore());
  }

  Future<void> deleteData(String id) async {
    await _dataCollection.doc(id).delete();
  }

  Stream<List<DataModel>> getData() {
    return _dataCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) =>
            DataModel.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList());
  }
}
