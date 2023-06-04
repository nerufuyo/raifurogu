import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raifurogu/data/models/data_model.dart';

class FirestoreService {
  final CollectionReference _dataCollection =
      FirebaseFirestore.instance.collection('data');

  Future<String> addData(DataModel data) async {
    final counterRef =
        FirebaseFirestore.instance.collection('counters').doc('data');
    final result =
        await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(counterRef);
      final currentValue =
          snapshot.exists ? snapshot.data()!['value'] as int : 0;
      final newValue = currentValue + 1;
      transaction.set(counterRef, {'value': newValue});
      return newValue;
    });
    final docRef =
        FirebaseFirestore.instance.collection('data').doc(result.toString());
    await docRef.set(data.toFirestore());
    return docRef.id;
  }

Future<void> updateData(String id, String title, String description) async {
    await _dataCollection.doc(id).update({
      'title': title,
      'description': description,
    });
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

  Stream<DataModel> getDataById(String id) {
    return _dataCollection.doc(id).snapshots().map((snapshot) =>
        DataModel.fromFirestore(snapshot.data() as Map<String, dynamic>));
  }
}
