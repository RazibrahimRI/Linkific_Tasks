import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final String userEmail;

  const DashboardScreen({super.key, required this.userEmail});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // MaterialBanner has to be shown after the first frame — the
    // ScaffoldMessenger isn't attached yet during initState itself.
    WidgetsBinding.instance.addPostFrameCallback((_) => _showWelcomeBanner());
  }

  void _showWelcomeBanner() {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: const Text('Welcome back!'),
        actions: [
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: const Text('DISMISS'),
          ),
        ],
      ),
    );
  }

  // AlertDialog — confirm a destructive action.
  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete project?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Delete')),
        ],
      ),
    );
  }

  // SimpleDialog — pick one option from a list.
  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choose theme'),
        children: [
          SimpleDialogOption(onPressed: () => Navigator.pop(context), child: const Text('Light')),
          SimpleDialogOption(onPressed: () => Navigator.pop(context), child: const Text('Dark')),
          SimpleDialogOption(
              onPressed: () => Navigator.pop(context), child: const Text('System default')),
        ],
      ),
    );
  }

  // Custom dialog — built from a plain Dialog widget, not AlertDialog/SimpleDialog.
  // This is what distinguishes it from the two above: full control over layout.
  void _showCustomDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.celebration, size: 48, color: Colors.indigo),
              const SizedBox(height: 12),
              const Text('Nice work!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('You just triggered a fully custom dialog.', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Got it'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // BottomSheet — quick actions.
  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String label, String value) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: _showQuickActions),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/login'));
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Welcome, ${widget.userEmail}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          // 3 stat cards, matching the "Projects: 12, Tasks: 28, Completed: 18" spec.
          Row(
            children: [
              _statCard('Projects', '12'),
              const SizedBox(width: 12),
              _statCard('Tasks', '28'),
              const SizedBox(width: 12),
              _statCard('Completed', '18'),
            ],
          ),
          const SizedBox(height: 16),

          Card(
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  trailing: Icon(Icons.chevron_right),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.folder),
                  title: Text('Projects'),
                  trailing: Icon(Icons.chevron_right),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.bar_chart),
                  title: Text('Analytics'),
                  trailing: Icon(Icons.chevron_right),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Add Project (Form)'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.pushNamed(context, '/form'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // The 4 dialog triggers, laid out as a simple button grid.
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton(onPressed: _showDeleteDialog, child: const Text('Delete')),
              OutlinedButton(onPressed: _showThemeDialog, child: const Text('Choose')),
              OutlinedButton(onPressed: _showCustomDialog, child: const Text('Custom')),
              OutlinedButton(onPressed: _showQuickActions, child: const Text('More options')),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/form'),
        child: const Icon(Icons.add),
      ),
    );
  }
}