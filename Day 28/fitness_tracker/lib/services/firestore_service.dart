import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/workout.dart';
import '../models/goal.dart';
import '../models/water_log.dart';

class FirestoreService {
  final String uid;
  FirestoreService(this.uid);

  DocumentReference<Map<String, dynamic>> get _user =>
      FirebaseFirestore.instance.collection('users').doc(uid);
  // ---- Goals ----
  DocumentReference<Map<String, dynamic>> get _goalDoc =>
      _user.collection('goals').doc('current');

  Stream<Goal> goalStream() => _goalDoc
      .snapshots()
      .map((s) => s.exists ? Goal.fromMap(s.data()!) : const Goal());

  // ---- Water ----
  Stream<List<WaterLog>> todayWaterStream() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    return _user
        .collection('waterLogs')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .orderBy('date', descending: true)
        .snapshots()
        .map((s) => s.docs.map(WaterLog.fromDoc).toList());
  }

  Future<void> addWater(WaterLog w) =>
      _user.collection('waterLogs').add(w.toMap());



  Future<void> saveGoal(Goal g) => _goalDoc.set(g.toMap());

  // ---- Workouts ----
  Stream<List<Workout>> workoutsStream() => _user
      .collection('workouts')
      .orderBy('date', descending: true)
      .snapshots()
      .map((s) => s.docs.map(Workout.fromDoc).toList());

  Future<void> addWorkout(Workout w) =>
      _user.collection('workouts').add(w.toMap());

  Future<void> deleteWaterLog(String id) =>
      _user.collection('waterLogs').doc(id).delete();

  Future<void> updateWorkout(Workout w) =>
      _user.collection('workouts').doc(w.id).update(w.toMap());

  Future<void> deleteWorkout(String id) =>
      _user.collection('workouts').doc(id).delete();


}