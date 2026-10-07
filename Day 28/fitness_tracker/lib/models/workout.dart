import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  final String? id;
  final String name;
  final int durationMinutes;
  final DateTime date;

  Workout({
    this.id,
    required this.name,
    required this.durationMinutes,
    required this.date,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'durationMinutes': durationMinutes,
    'date': Timestamp.fromDate(date),
  };

  factory Workout.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    return Workout(
      id: doc.id,
      name: d['name'] as String,
      durationMinutes: (d['durationMinutes'] as num).toInt(),
      date: (d['date'] as Timestamp).toDate(),
    );
  }
}

