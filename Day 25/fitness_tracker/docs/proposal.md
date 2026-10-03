# Project Proposal: Fitness Tracker

## Selected Project
D. Fitness Tracker, a Flutter app with a Firebase backend.

## Team
Completed individually as instructed by the mentor.
Razi Ibrahim (GitHub: RazibrahimRI)

## Features
1. User authentication: sign up, log in, log out with email and password.
2. Workout logging: add, view, edit, delete a workout (name, minutes, date).
3. Progress charts: bar chart of workout minutes per day for the last 7 days.
4. Goal setting: set a weekly workout minutes goal and a daily water goal, and see progress.
5. BMI calculator: enter height and weight, see BMI and category. Not saved.
6. Water intake tracker: add water in ml, see today's total against the goal.
7. Data persistence: workouts, water entries and goals are saved in Firebase for each user.

## User Flows
1. New user: Open app > Sign Up > enter email and password > Workout List.
2. Returning user: Open app > Login > Workout List (skipped if already logged in).
3. Log a workout: Workout List > Add button > fill name, minutes, date > Save > back to list.
4. Edit or delete a workout: Workout List > tap a workout > change and Save, or Delete.
5. View progress: Progress Charts tab > see the 7-day chart.
6. Set goals: Goals tab > enter weekly minutes and daily water > Save > see progress.
7. Track water: Water Tracker tab > enter ml > Add > today's total updates.
8. Check BMI: BMI Calculator tab > enter height and weight > Calculate > see result.
9. Log out: Logout button on the top bar > Login screen.

## Screens Needed
1. Login
2. Sign Up
3. Workout List
4. Add/Edit Workout
5. Progress Charts
6. Goals
7. Water Tracker
8. BMI Calculator

## API Requirements
The app has no server of its own. It uses these Firebase calls:
- Firebase Authentication: create account, log in, log out, check if a user is logged in.
- Cloud Firestore (for the logged-in user only):
    - Workouts: add, read all, update, delete
    - Water entries: add, read today's entries
    - Goals: save, read
    - Chart data: read workouts from the last 7 days
- BMI needs no call. It is calculated on the phone.

## Database Schema (Cloud Firestore)
```
users/{userId}
  email (text)
  createdAt (date)

users/{userId}/workouts/{workoutId}
  name (text)
  durationMinutes (number)
  date (date)

users/{userId}/waterLogs/{logId}
  amountMl (number)
  date (date)

users/{userId}/goals/current
  weeklyWorkoutMinutes (number)
  dailyWaterMl (number)
```
Charts are built from the workouts. BMI is not saved.