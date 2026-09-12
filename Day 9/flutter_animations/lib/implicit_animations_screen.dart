import 'package:flutter/material.dart';

class ImplicitAnimationsScreen extends StatefulWidget {
  const ImplicitAnimationsScreen({super.key});

  @override
  State<ImplicitAnimationsScreen> createState() => _ImplicitAnimationsScreenState();
}

class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen> {

  bool _expanded = false;
  bool _visible = true;
  bool _moved = false;
  bool _showFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Implicit Animations')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(
            'AnimatedContainer  (Curves.easeIn)',
            Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                  width: _expanded ? 220 : 100,
                  height: _expanded ? 100 : 60,
                  decoration: BoxDecoration(
                    color: _expanded ? Colors.indigo : Colors.teal,
                    borderRadius: BorderRadius.circular(_expanded ? 24 : 8),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _expanded = !_expanded),
                  child: const Text('Toggle size / color / radius'),
                ),
              ],
            ),
          ),
          _section(
            'AnimatedOpacity  (Curves.easeOut)',
            Column(
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  opacity: _visible ? 1.0 : 0.0,
                  child: Container(
                    width: 120,
                    height: 60,
                    color: Colors.orange,
                    alignment: Alignment.center,
                    child: const Text('Fades'),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _visible = !_visible),
                  child: const Text('Toggle visibility'),
                ),
              ],
            ),
          ),
          _section(
            'AnimatedPositioned  (Curves.bounceIn, inside a Stack)',
            Column(
              children: [
                SizedBox(
                  height: 120,
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.bounceIn,
                        left: _moved ? 200 : 0,
                        top: _moved ? 60 : 0,
                        child: Container(
                          width: 60,
                          height: 60,
                          color: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _moved = !_moved),
                  child: const Text('Move widget'),
                ),
              ],
            ),
          ),
          _section(
            'AnimatedCrossFade  (Login / Register toggle)',
            Column(
              children: [
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 400),
                  crossFadeState:
                  _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  firstChild: const _MiniForm(title: 'Login', fields: ['Email', 'Password']),
                  secondChild: const _MiniForm(
                    title: 'Register',
                    fields: ['Name', 'Email', 'Password'],
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => setState(() => _showFirst = !_showFirst),
                  child: const Text('Switch Login / Register'),
                ),
              ],
            ),
          ),
          _section(
            'TweenAnimationBuilder  (custom curve)',
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 100),
              duration: const Duration(seconds: 2),
              curve: const _CustomCurve(),
              builder: (context, value, child) {
                return Text(
                  value.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, Widget child) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _MiniForm extends StatelessWidget {
  final String title;
  final List<String> fields;
  const _MiniForm({required this.title, required this.fields});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ...fields.map((f) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: TextField(decoration: InputDecoration(labelText: f)),
        )),
      ],
    );
  }
}

class _CustomCurve extends Curve {
  const _CustomCurve();
  @override
  double transform(double t) => t * t * (3 - 2 * t);
}