import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workout_provider.dart';

class ProgressChartsScreen extends StatelessWidget {
  const ProgressChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = context.watch<WorkoutProvider>().minutesLast7Days();
    final today = DateTime.now();
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        const Text('Workout minutes per day (last 7 days)'),
        const SizedBox(height: 24),
        SizedBox(
          height: 300,
          child: BarChart(BarChartData(
            barGroups: [
              for (var i = 0; i < 7; i++)
                BarChartGroupData(x: i, barRods: [
                  BarChartRodData(toY: data[i].toDouble(), width: 16),
                ]),
            ],
            titlesData: FlTitlesData(
              topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final day =
                    today.subtract(Duration(days: 6 - value.toInt()));
                    return Text(names[day.weekday - 1]);
                  },
                ),
              ),
            ),
          )),
        ),
      ]),
    );
  }
}