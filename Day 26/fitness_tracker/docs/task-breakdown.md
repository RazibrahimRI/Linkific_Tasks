# Task Breakdown

## Assign Tasks
All tasks are assigned to Razi Ibrahim, in this order:

| # | Task | Feature | Branch |
|---|------|---------|--------|
| 1 | Login, Sign Up, Logout | User authentication | feature/auth |
| 2 | Add, list, edit, delete workouts | Workout logging, data persistence | feature/workouts |
| 3 | 7-day bar chart | Progress charts | feature/charts |
| 4 | Save and show goals | Goal setting | feature/goals |
| 5 | Add water, today's total | Water intake tracker | feature/water |
| 6 | BMI form and result | BMI calculator | feature/bmi |
| 7 | Bottom navigation | Navigation flow | feature/auth |

## Git Workflow
- `main` always works. No direct commits to `main`.
- One branch per task (see table). Documents use `docs/project-documents`.
- Short commit messages, for example "Add workout list screen".
- Merge into `main` only through a GitHub pull request.

## Code Review Process
- The author reviews their own pull request the next day, then merges.
- Checklist before merging:
    - Does it match the requirement for that feature?
    - Does it run without errors?
    - Are there unused files or leftover test code?
    - Does it use only the 5 chosen packages?
- The mentor is asked to review at least one pull request.

## Daily Standup Schedule
- Every day at 9:00 AM, 10 minutes.
- Written in 3 lines: done yesterday, doing today, blocked by.