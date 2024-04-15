import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName;
  final  String subcollectionName= "daily_calculations";
  FirestoreService(this.collectionName);

  Future<void> createData(Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionName).add(data);
    } catch (e) {
      print('Veri ekleme hatası: $e');
    }
  }

  Future<void> createDataWithCustomId(String documentId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionName).doc(documentId).set(data);
      print('Belge oluşturuldu: $documentId');
    } catch (e) {
      print('Veri ekleme hatası: $e');
    }
  }

  Future<void> createSubcollectionData(
      {required String documentId,
       String subcollectionName= "daily_calculations",
      required Map<String, dynamic> data}) async {
    try {
      await _firestore
          .collection(collectionName)
          .doc(documentId)
          .collection(subcollectionName)
          .add(data);
      print('Alt koleksiyona belge eklendi.');
    } catch (e) {
      print('Alt koleksiyona belge ekleme hatası: $e');
    }
  }

  Future<Map<String, dynamic>?> readData(String documentId) async {
    try {
      DocumentSnapshot document = await _firestore.collection(collectionName).doc(documentId).get();

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
      await _firestore.collection(collectionName).doc(documentId).update(newData);
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
