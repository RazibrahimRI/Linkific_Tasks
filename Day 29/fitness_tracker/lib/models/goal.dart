class Goal {
  final int weeklyWorkoutMinutes;
  final int dailyWaterMl;
  const Goal({this.weeklyWorkoutMinutes = 150, this.dailyWaterMl = 2000});

  Map<String, dynamic> toMap() => {
    'weeklyWorkoutMinutes': weeklyWorkoutMinutes,
    'dailyWaterMl': dailyWaterMl,
  };

  factory Goal.fromMap(Map<String, dynamic> m) => Goal(
    weeklyWorkoutMinutes: (m['weeklyWorkoutMinutes'] as num).toInt(),
    dailyWaterMl: (m['dailyWaterMl'] as num).toInt(),
  );
}
