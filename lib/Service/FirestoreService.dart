import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServis {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName; // Firestore koleksiyon adı

  FirestoreServis(this.collectionName);

  Future<void> createData(Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionName).add(data);
    } catch (e) {
      print('Veri ekleme hatası: $e');
    }
  }

  Future<Map<String, dynamic>?> readData(String documentId) async {
    try {
      DocumentSnapshot document =
      await _firestore.collection(collectionName).doc(documentId).get();

      if (document.exists) {
        return document.data() as Map<String, dynamic>;
      } else {
        print('Belirtilen belge bulunamadı.');
        return null;
      }
    } catch (e) {
      print('Veri okuma hatası: $e');
      return null;
    }
  }

  Future<void> updateData(String documentId, Map<String, dynamic> newData) async {
    try {
      await _firestore
          .collection(collectionName)
          .doc(documentId)
          .update(newData);
    } catch (e) {
      print('Veri güncelleme hatası: $e');
    }
  }

  Future<void> deleteData(String documentId) async {
    try {
      await _firestore.collection(collectionName).doc(documentId).delete();
    } catch (e) {
      print('Veri silme hatası: $e');
    }
  }
}
