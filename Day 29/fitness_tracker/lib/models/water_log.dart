import 'package:cloud_firestore/cloud_firestore.dart';

class WaterLog {
  final String? id;
  final int amountMl;
  final DateTime date;

  WaterLog({this.id, required this.amountMl, required this.date});

  Map<String, dynamic> toMap() => {
    'amountMl': amountMl,
    'date': Timestamp.fromDate(date),
  };

  factory WaterLog.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data()!;
    return WaterLog(
      id: doc.id,
      amountMl: (d['amountMl'] as num).toInt(),
      date: (d['date'] as Timestamp).toDate(),
    );
  }
}
