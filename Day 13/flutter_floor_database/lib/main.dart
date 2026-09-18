import 'package:flutter/material.dart';
import '/app_database.dart';
import 'screens/homescreen_.dart';

late AppDatabase database;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = await $FloorAppDatabase
      .databaseBuilder('notes_app.db')
      .addMigrations([migration1to2])
      .build();
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floor Notes',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: HomeScreen(database: database),
    );
  }
}