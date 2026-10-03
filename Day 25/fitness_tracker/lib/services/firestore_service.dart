import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/workout.dart';

class FirestoreService {
  final String uid;
  FirestoreService(this.uid);

  DocumentReference<Map<String, dynamic>> get _user =>
      FirebaseFirestore.instance.collection('users').doc(uid);

  // ---- Workouts ----
  Stream<List<Workout>> workoutsStream() => _user
      .collection('workouts')
      .orderBy('date', descending: true)
      .snapshots()
      .map((s) => s.docs.map(Workout.fromDoc).toList());

  Future<void> addWorkout(Workout w) =>
      _user.collection('workouts').add(w.toMap());

  Future<void> updateWorkout(Workout w) =>
      _user.collection('workouts').doc(w.id).update(w.toMap());

  Future<void> deleteWorkout(String id) =>
      _user.collection('workouts').doc(id).delete();
}