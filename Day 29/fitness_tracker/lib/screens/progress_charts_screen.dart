import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workout_provider.dart';

// Bar chart of workout minutes for the last 7 days, with an empty-state message.
class ProgressChartsScreen extends StatelessWidget {
  const ProgressChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WorkoutProvider>();
    if (provider.error != null) {
      return Center(child: Text(provider.error!));
    }
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final data = provider.minutesLast7Days();
    final hasData = data.any((m) => m > 0);
    final today = DateTime.now();
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final barColor = Theme.of(context).colorScheme.primary;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Workout minutes per day (last 7 days)',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (!hasData)
            const Padding(
              padding: EdgeInsets.only(top: 48),
              child: Text(
                'No workouts in the last 7 days. Add one to see your chart.',
                textAlign: TextAlign.center,
              ),
            )
          else
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    for (var i = 0; i < 7; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: data[i].toDouble(),
                            width: 16,
                            color: barColor,
                          ),
                        ],
                      ),
                  ],
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final day = today.subtract(
                            Duration(days: 6 - value.toInt()),
                          );
                          return Text(names[day.weekday - 1]);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
