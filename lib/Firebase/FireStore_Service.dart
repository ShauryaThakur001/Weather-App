import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current user ID
  String get _uid => _auth.currentUser!.uid;

  /// Add a city to saved locations
  Future<void> addCity(String cityName) async {
    await _firestore
        .collection("users")
        .doc(_uid)
        .collection("savedLocations")
        .doc(cityName)
        .set({
      "city": cityName,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  /// Remove a city
  Future<void> removeCity(String cityName) async {
    await _firestore
        .collection("users")
        .doc(_uid)
        .collection("savedLocations")
        .doc(cityName)
        .delete();
  }

  /// Get saved cities (real-time)
  Stream<List<String>> getSavedCities() {
    return _firestore
        .collection("users")
        .doc(_uid)
        .collection("savedLocations")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc["city"] as String).toList();
    });
  }
}
