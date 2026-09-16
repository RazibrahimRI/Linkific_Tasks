import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Permissions Demo',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const PermissionsScreen(),
    );
  }
}

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  String statusMessage = 'No permission requested yet';

  // ---- Camera flow (includes rationale dialog) ----
  Future<void> requestCameraWithRationale() async {
    bool shouldShowRationale = await Permission.camera.shouldShowRequestRationale;

    if (shouldShowRationale) {
      bool proceed = await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Camera access needed'),
          content: const Text('We use your camera to demonstrate the permission flow.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('No')),
            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('OK')),
          ],
        ),
      ) ??
          false;
      if (!proceed) return;
    }

    final status = await Permission.camera.request();
    handleResult('Camera', status);
  }

  // ---- Location flow ----
  Future<void> requestLocation() async {
    final status = await Permission.location.request();
    handleResult('Location', status);
  }

  // ---- Storage flow ----
  Future<void> requestStorage() async {
    PermissionStatus status;

    if (Theme.of(context).platform == TargetPlatform.android) {
      // On Android 13+, storage permission is replaced by media-specific ones
      status = await Permission.photos.request();
    } else {
      status = await Permission.storage.request();
    }

    handleResult('Storage', status);
  }

  // ---- Shared result handler ----
  void handleResult(String label, PermissionStatus status) {
    if (status.isGranted) {
      setState(() => statusMessage = '$label: Granted ✅');
    } else if (status.isPermanentlyDenied) {
      setState(() => statusMessage = '$label: Permanently denied 🚫');
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Permission required'),
          content: Text('$label permission is permanently denied. Enable it from settings.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
    } else {
      setState(() => statusMessage = '$label: Denied ❌');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$label permission denied.')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permissions Demo')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: requestCameraWithRationale,
              child: const Text('Request Camera'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: requestLocation,
              child: const Text('Request Location'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: requestStorage,
              child: const Text('Request Storage'),
            ),
            const SizedBox(height: 32),
            Text(
              statusMessage,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}