from django.contrib.auth.models import Group, Permission
from django.core.management.base import BaseCommand
from django.utils import timezone

from apps.content.models import Post
from apps.programs.models import Program, ProgramDay, ProgramWeek
from apps.tenants.models import Tenant
from apps.users.models import CustomUser
from apps.workouts.models import Exercise, ExerciseInWorkout, Workout

# ---------------------------------------------------------------------------
# Permission definitions for the "Tenant Admin" group
# ---------------------------------------------------------------------------
# Format: (app_label, model_name, [actions])
# Full CRUD for content models, view-only for progress/logs.
TENANT_ADMIN_PERMISSIONS = [
    ("tenants", "tenant", ["view", "change"]),
    ("users", "customuser", ["view", "change"]),
    ("workouts", "exercise", ["view", "add", "change", "delete"]),
    ("workouts", "workout", ["view", "add", "change", "delete"]),
    ("workouts", "exerciseinworkout", ["view", "add", "change", "delete"]),
    ("programs", "program", ["view", "add", "change", "delete"]),
    ("programs", "programweek", ["view", "add", "change", "delete"]),
    ("programs", "programday", ["view", "add", "change", "delete"]),
    ("content", "post", ["view", "add", "change", "delete"]),
    ("media_library", "mediafile", ["view", "add", "change", "delete"]),
    ("progress", "workoutlog", ["view"]),
    ("progress", "exerciselog", ["view"]),
    ("progress", "programprogress", ["view"]),
]

# ---------------------------------------------------------------------------
# Tenant definitions
# ---------------------------------------------------------------------------
TENANTS = [
    {
        "slug": "iron-athletics",
        "name": "Iron Athletics",
        "app_name": "Iron Athletics",
        "primary_color": "#FF5722",
        "secondary_color": "#FF9800",
    },
    {
        "slug": "zen-fitness",
        "name": "Zen Fitness",
        "app_name": "Zen Fitness",
        "primary_color": "#00BFA5",
        "secondary_color": "#26C6DA",
    },
]

# ---------------------------------------------------------------------------
# Admin users per tenant
# ---------------------------------------------------------------------------
ADMIN_USERS = {
    "iron-athletics": {
        "email": "coach@ironathletics.com",
        "password": "iron1234",
        "first_name": "Marcus",
        "last_name": "Steel",
    },
    "zen-fitness": {
        "email": "coach@zenfitness.com",
        "password": "zen1234",
        "first_name": "Aria",
        "last_name": "Chen",
    },
}

# ---------------------------------------------------------------------------
# Exercises per tenant
# ---------------------------------------------------------------------------
EXERCISES = {
    "iron-athletics": [
        {"name": "Barbell Back Squat", "muscle_groups": ["quads", "glutes", "core"], "equipment": "barbell",
         "description": "The king of lower body exercises. Drive through your heels and keep your chest up.",
         "instructions": "1. Set barbell on upper traps\n2. Unrack and step back\n3. Squat to parallel or below\n4. Drive up through heels"},
        {"name": "Bench Press", "muscle_groups": ["chest", "triceps", "shoulders"], "equipment": "barbell",
         "description": "Fundamental upper body pressing movement for chest development.",
         "instructions": "1. Lie on bench, grip bar shoulder-width\n2. Unrack and lower to mid-chest\n3. Press up to lockout"},
        {"name": "Conventional Deadlift", "muscle_groups": ["hamstrings", "glutes", "back", "core"], "equipment": "barbell",
         "description": "Full-body pull from the floor. The ultimate strength builder.",
         "instructions": "1. Stand with feet hip-width, bar over mid-foot\n2. Hinge and grip the bar\n3. Brace core and lift by extending hips and knees\n4. Lock out at the top"},
        {"name": "Overhead Press", "muscle_groups": ["shoulders", "triceps", "core"], "equipment": "barbell",
         "description": "Strict standing press for shoulder strength and stability.",
         "instructions": "1. Clean bar to shoulders or unrack at chin height\n2. Brace core\n3. Press overhead to lockout\n4. Lower under control"},
        {"name": "Barbell Row", "muscle_groups": ["back", "biceps", "rear delts"], "equipment": "barbell",
         "description": "Bent-over row for a thick, strong back.",
         "instructions": "1. Hinge forward ~45 degrees\n2. Grip bar slightly wider than shoulder-width\n3. Row to lower chest\n4. Lower under control"},
        {"name": "Romanian Deadlift", "muscle_groups": ["hamstrings", "glutes", "lower back"], "equipment": "barbell",
         "description": "Hip-hinge movement targeting the posterior chain.",
         "instructions": "1. Hold bar at hip height\n2. Push hips back, slight knee bend\n3. Lower bar along thighs until stretch in hamstrings\n4. Drive hips forward to return"},
        {"name": "Pull-Ups", "muscle_groups": ["back", "biceps", "core"], "equipment": "pull-up bar",
         "description": "Bodyweight vertical pull — the gold standard for back development.",
         "instructions": "1. Hang from bar with overhand grip\n2. Pull chin above bar\n3. Lower under control to full extension"},
        {"name": "Walking Lunges", "muscle_groups": ["quads", "glutes", "hamstrings"], "equipment": "dumbbells",
         "description": "Unilateral leg exercise for balance and hypertrophy.",
         "instructions": "1. Hold dumbbells at sides\n2. Step forward into a lunge\n3. Lower back knee toward floor\n4. Drive through front foot and step forward"},
        {"name": "Barbell Curls", "muscle_groups": ["biceps", "forearms"], "equipment": "barbell",
         "description": "Classic bicep builder with a straight bar.",
         "instructions": "1. Stand with bar at arm's length\n2. Curl bar up, keeping elbows pinned\n3. Squeeze at top\n4. Lower under control"},
        {"name": "Dips", "muscle_groups": ["triceps", "chest", "shoulders"], "equipment": "dip bars",
         "description": "Upper body push for triceps and lower chest.",
         "instructions": "1. Support yourself on dip bars\n2. Lower body by bending elbows\n3. Press back up to lockout"},
    ],
    "zen-fitness": [
        {"name": "Sun Salutation A", "muscle_groups": ["full body"], "equipment": "bodyweight",
         "description": "A flowing sequence that warms the entire body and connects breath with movement.",
         "instructions": "1. Mountain Pose → Forward Fold\n2. Halfway Lift → Chaturanga\n3. Upward Dog → Downward Dog\n4. Step forward → Rise to Mountain"},
        {"name": "Warrior II", "muscle_groups": ["legs", "core", "shoulders"], "equipment": "bodyweight",
         "description": "A powerful standing pose that builds leg strength and opens the hips.",
         "instructions": "1. Step feet wide apart\n2. Turn front foot out 90 degrees\n3. Bend front knee over ankle\n4. Extend arms parallel to floor, gaze over front hand"},
        {"name": "Downward Facing Dog", "muscle_groups": ["hamstrings", "shoulders", "calves", "back"], "equipment": "bodyweight",
         "description": "Foundation inversion that lengthens the spine and stretches the whole back body.",
         "instructions": "1. Start on hands and knees\n2. Tuck toes and lift hips high\n3. Press chest toward thighs\n4. Pedal heels toward the floor"},
        {"name": "Chair Pose", "muscle_groups": ["quads", "glutes", "core"], "equipment": "bodyweight",
         "description": "A fierce standing pose that builds heat and strengthens the lower body.",
         "instructions": "1. Stand with feet together\n2. Bend knees and sit back\n3. Reach arms overhead\n4. Keep weight in heels, chest lifted"},
        {"name": "Plank Hold", "muscle_groups": ["core", "shoulders", "back"], "equipment": "bodyweight",
         "description": "Isometric core stabilizer that builds full-body endurance.",
         "instructions": "1. Place hands under shoulders\n2. Step feet back, body in a straight line\n3. Engage core, don't let hips sag\n4. Hold and breathe"},
        {"name": "Bridge Pose", "muscle_groups": ["glutes", "hamstrings", "spine"], "equipment": "bodyweight",
         "description": "Gentle backbend that opens the chest and strengthens the posterior chain.",
         "instructions": "1. Lie on back, knees bent, feet flat\n2. Press into feet and lift hips\n3. Clasp hands beneath you (optional)\n4. Hold, breathing into chest"},
        {"name": "Tree Pose", "muscle_groups": ["legs", "core", "balance"], "equipment": "bodyweight",
         "description": "A balancing pose that cultivates focus, stability, and calm.",
         "instructions": "1. Stand on one leg\n2. Place opposite foot on inner thigh or calf (not knee)\n3. Bring hands to heart or overhead\n4. Find a steady gaze point"},
        {"name": "Pigeon Pose", "muscle_groups": ["hips", "glutes", "hip flexors"], "equipment": "bodyweight",
         "description": "Deep hip opener that releases tension stored in the hips.",
         "instructions": "1. From Downward Dog, bring right knee forward\n2. Place right shin on the mat\n3. Extend left leg back\n4. Fold forward over front leg for deeper stretch"},
        {"name": "Boat Pose", "muscle_groups": ["core", "hip flexors"], "equipment": "bodyweight",
         "description": "Core-intensive balance pose that strengthens the deep abdominals.",
         "instructions": "1. Sit with knees bent, feet on floor\n2. Lean back slightly, lift feet\n3. Extend legs to 45 degrees (or keep bent)\n4. Reach arms forward parallel to floor"},
        {"name": "Cobra Pose", "muscle_groups": ["spine", "chest", "shoulders"], "equipment": "bodyweight",
         "description": "Gentle backbend that opens the heart and strengthens the spinal extensors.",
         "instructions": "1. Lie face down, hands under shoulders\n2. Press into hands and lift chest\n3. Keep elbows slightly bent\n4. Draw shoulders away from ears"},
    ],
}

# ---------------------------------------------------------------------------
# Workouts per tenant (reference exercises by name)
# ---------------------------------------------------------------------------
WORKOUTS = {
    "iron-athletics": [
        {
            "title": "Heavy Upper",
            "description": "Upper body strength session focused on pressing and pulling movements.",
            "estimated_duration_minutes": 60,
            "exercises": [
                {"name": "Bench Press", "sets": 5, "reps": "5", "rest_seconds": 180},
                {"name": "Barbell Row", "sets": 4, "reps": "6-8", "rest_seconds": 120},
                {"name": "Overhead Press", "sets": 4, "reps": "6-8", "rest_seconds": 120},
                {"name": "Pull-Ups", "sets": 3, "reps": "8-10", "rest_seconds": 90},
                {"name": "Dips", "sets": 3, "reps": "10-12", "rest_seconds": 90},
                {"name": "Barbell Curls", "sets": 3, "reps": "10-12", "rest_seconds": 60},
            ],
        },
        {
            "title": "Heavy Lower",
            "description": "Leg day built around the squat. Develop raw lower body power.",
            "estimated_duration_minutes": 55,
            "exercises": [
                {"name": "Barbell Back Squat", "sets": 5, "reps": "5", "rest_seconds": 180},
                {"name": "Romanian Deadlift", "sets": 4, "reps": "8-10", "rest_seconds": 120},
                {"name": "Walking Lunges", "sets": 3, "reps": "12 each", "rest_seconds": 90},
                {"name": "Barbell Curls", "sets": 3, "reps": "10-12", "rest_seconds": 60},
            ],
        },
        {
            "title": "Deadlift Day",
            "description": "Posterior chain focused session with the deadlift as the main lift.",
            "estimated_duration_minutes": 50,
            "exercises": [
                {"name": "Conventional Deadlift", "sets": 5, "reps": "3-5", "rest_seconds": 240},
                {"name": "Barbell Row", "sets": 4, "reps": "8-10", "rest_seconds": 120},
                {"name": "Romanian Deadlift", "sets": 3, "reps": "10-12", "rest_seconds": 90},
                {"name": "Pull-Ups", "sets": 3, "reps": "AMRAP", "rest_seconds": 90},
            ],
        },
        {
            "title": "Full Body Power",
            "description": "Hit every major muscle group in one explosive session.",
            "estimated_duration_minutes": 65,
            "exercises": [
                {"name": "Barbell Back Squat", "sets": 4, "reps": "6", "rest_seconds": 150},
                {"name": "Bench Press", "sets": 4, "reps": "6", "rest_seconds": 150},
                {"name": "Conventional Deadlift", "sets": 3, "reps": "5", "rest_seconds": 180},
                {"name": "Overhead Press", "sets": 3, "reps": "8", "rest_seconds": 120},
                {"name": "Pull-Ups", "sets": 3, "reps": "8-10", "rest_seconds": 90},
                {"name": "Dips", "sets": 3, "reps": "10-12", "rest_seconds": 60},
            ],
        },
    ],
    "zen-fitness": [
        {
            "title": "Morning Flow",
            "description": "A gentle, energising morning sequence to awaken the body and mind.",
            "estimated_duration_minutes": 30,
            "exercises": [
                {"name": "Sun Salutation A", "sets": 5, "reps": "1 round", "rest_seconds": 15},
                {"name": "Warrior II", "sets": 2, "reps": "30 sec each side", "rest_seconds": 10},
                {"name": "Chair Pose", "sets": 3, "reps": "30 sec", "rest_seconds": 10},
                {"name": "Tree Pose", "sets": 2, "reps": "30 sec each side", "rest_seconds": 10},
                {"name": "Downward Facing Dog", "sets": 1, "reps": "60 sec", "rest_seconds": 0},
            ],
        },
        {
            "title": "Core & Balance",
            "description": "Build inner strength and stability with core-focused poses.",
            "estimated_duration_minutes": 35,
            "exercises": [
                {"name": "Plank Hold", "sets": 3, "reps": "45 sec", "rest_seconds": 30},
                {"name": "Boat Pose", "sets": 3, "reps": "30 sec", "rest_seconds": 20},
                {"name": "Chair Pose", "sets": 3, "reps": "30 sec", "rest_seconds": 15},
                {"name": "Tree Pose", "sets": 2, "reps": "45 sec each side", "rest_seconds": 10},
                {"name": "Bridge Pose", "sets": 3, "reps": "30 sec", "rest_seconds": 15},
            ],
        },
        {
            "title": "Hip Opening Flow",
            "description": "Release deep tension in the hips with long-held stretches.",
            "estimated_duration_minutes": 40,
            "exercises": [
                {"name": "Sun Salutation A", "sets": 3, "reps": "1 round", "rest_seconds": 10},
                {"name": "Warrior II", "sets": 2, "reps": "45 sec each side", "rest_seconds": 10},
                {"name": "Pigeon Pose", "sets": 2, "reps": "60 sec each side", "rest_seconds": 15},
                {"name": "Downward Facing Dog", "sets": 2, "reps": "45 sec", "rest_seconds": 10},
                {"name": "Bridge Pose", "sets": 2, "reps": "45 sec", "rest_seconds": 15},
                {"name": "Cobra Pose", "sets": 2, "reps": "30 sec", "rest_seconds": 10},
            ],
        },
        {
            "title": "Full Body Restore",
            "description": "A nourishing practice that stretches, strengthens, and restores every part of the body.",
            "estimated_duration_minutes": 45,
            "exercises": [
                {"name": "Sun Salutation A", "sets": 4, "reps": "1 round", "rest_seconds": 10},
                {"name": "Warrior II", "sets": 2, "reps": "30 sec each side", "rest_seconds": 10},
                {"name": "Chair Pose", "sets": 2, "reps": "30 sec", "rest_seconds": 10},
                {"name": "Plank Hold", "sets": 2, "reps": "30 sec", "rest_seconds": 15},
                {"name": "Cobra Pose", "sets": 2, "reps": "30 sec", "rest_seconds": 10},
                {"name": "Pigeon Pose", "sets": 2, "reps": "45 sec each side", "rest_seconds": 10},
                {"name": "Bridge Pose", "sets": 2, "reps": "30 sec", "rest_seconds": 10},
                {"name": "Boat Pose", "sets": 2, "reps": "30 sec", "rest_seconds": 15},
            ],
        },
    ],
}

# ---------------------------------------------------------------------------
# Programs per tenant
# ---------------------------------------------------------------------------
PROGRAMS = {
    "iron-athletics": [
        {
            "title": "Strength Foundations",
            "description": "A 4-week programme designed to build a solid base of barbell strength. Perfect for beginners who want to learn the big lifts with proper form and progressive overload.",
            "difficulty": "BEGINNER",
            "duration_weeks": 4,
            "is_free": True,
            "ordering": 1,
            "weeks": [
                {
                    "week_number": 1, "title": "Week 1 — Learning the Lifts",
                    "days": [
                        {"day": 1, "title": "Upper Body Intro", "workout": "Heavy Upper"},
                        {"day": 2, "title": "Rest Day", "rest": True},
                        {"day": 3, "title": "Lower Body Intro", "workout": "Heavy Lower"},
                        {"day": 4, "title": "Rest Day", "rest": True},
                        {"day": 5, "title": "Full Body", "workout": "Full Body Power"},
                        {"day": 6, "title": "Rest Day", "rest": True},
                        {"day": 7, "title": "Rest Day", "rest": True},
                    ],
                },
                {
                    "week_number": 2, "title": "Week 2 — Building Volume",
                    "days": [
                        {"day": 1, "title": "Heavy Upper", "workout": "Heavy Upper"},
                        {"day": 2, "title": "Heavy Lower", "workout": "Heavy Lower"},
                        {"day": 3, "title": "Rest Day", "rest": True},
                        {"day": 4, "title": "Deadlift Focus", "workout": "Deadlift Day"},
                        {"day": 5, "title": "Rest Day", "rest": True},
                        {"day": 6, "title": "Full Body", "workout": "Full Body Power"},
                        {"day": 7, "title": "Rest Day", "rest": True},
                    ],
                },
                {
                    "week_number": 3, "title": "Week 3 — Push Through",
                    "days": [
                        {"day": 1, "title": "Heavy Upper", "workout": "Heavy Upper"},
                        {"day": 2, "title": "Rest Day", "rest": True},
                        {"day": 3, "title": "Heavy Lower", "workout": "Heavy Lower"},
                        {"day": 4, "title": "Deadlift Focus", "workout": "Deadlift Day"},
                        {"day": 5, "title": "Rest Day", "rest": True},
                        {"day": 6, "title": "Full Body", "workout": "Full Body Power"},
                        {"day": 7, "title": "Rest Day", "rest": True},
                    ],
                },
                {
                    "week_number": 4, "title": "Week 4 — Test Your Strength",
                    "days": [
                        {"day": 1, "title": "Upper Max Effort", "workout": "Heavy Upper"},
                        {"day": 2, "title": "Lower Max Effort", "workout": "Heavy Lower"},
                        {"day": 3, "title": "Rest Day", "rest": True},
                        {"day": 4, "title": "Deadlift Max Effort", "workout": "Deadlift Day"},
                        {"day": 5, "title": "Rest Day", "rest": True},
                        {"day": 6, "title": "Full Body Finisher", "workout": "Full Body Power"},
                        {"day": 7, "title": "Rest & Celebrate", "rest": True},
                    ],
                },
            ],
        },
        {
            "title": "Powerlifting Peak",
            "description": "An advanced 6-week peaking programme for experienced lifters. Progressively heavier loads with intelligent deloads to hit PRs on squat, bench, and deadlift.",
            "difficulty": "ADVANCED",
            "duration_weeks": 6,
            "is_free": False,
            "ordering": 2,
            "weeks": [
                {
                    "week_number": w,
                    "title": f"Week {w} — {'Accumulation' if w <= 2 else 'Intensification' if w <= 4 else 'Deload' if w == 5 else 'Peak'}",
                    "days": [
                        {"day": 1, "title": "Squat Day", "workout": "Heavy Lower"},
                        {"day": 2, "title": "Bench Day", "workout": "Heavy Upper"},
                        {"day": 3, "title": "Rest Day", "rest": True},
                        {"day": 4, "title": "Deadlift Day", "workout": "Deadlift Day"},
                        {"day": 5, "title": "Accessory Day", "workout": "Full Body Power"},
                        {"day": 6, "title": "Rest Day", "rest": True},
                        {"day": 7, "title": "Rest Day", "rest": True},
                    ],
                }
                for w in range(1, 7)
            ],
        },
    ],
    "zen-fitness": [
        {
            "title": "Yoga for Beginners",
            "description": "A gentle 4-week introduction to yoga. Build flexibility, strength, and mindfulness with accessible poses and clear guidance.",
            "difficulty": "BEGINNER",
            "duration_weeks": 4,
            "is_free": True,
            "ordering": 1,
            "weeks": [
                {
                    "week_number": 1, "title": "Week 1 — Finding Your Foundation",
                    "days": [
                        {"day": 1, "title": "Morning Flow", "workout": "Morning Flow"},
                        {"day": 2, "title": "Rest & Reflect", "rest": True},
                        {"day": 3, "title": "Core Basics", "workout": "Core & Balance"},
                        {"day": 4, "title": "Rest Day", "rest": True},
                        {"day": 5, "title": "Morning Flow", "workout": "Morning Flow"},
                        {"day": 6, "title": "Rest Day", "rest": True},
                        {"day": 7, "title": "Gentle Restore", "workout": "Full Body Restore"},
                    ],
                },
                {
                    "week_number": 2, "title": "Week 2 — Opening Up",
                    "days": [
                        {"day": 1, "title": "Morning Flow", "workout": "Morning Flow"},
                        {"day": 2, "title": "Hip Opening", "workout": "Hip Opening Flow"},
                        {"day": 3, "title": "Rest Day", "rest": True},
                        {"day": 4, "title": "Core & Balance", "workout": "Core & Balance"},
                        {"day": 5, "title": "Rest Day", "rest": True},
                        {"day": 6, "title": "Full Body Restore", "workout": "Full Body Restore"},
                        {"day": 7, "title": "Rest Day", "rest": True},
                    ],
                },
                {
                    "week_number": 3, "title": "Week 3 — Building Strength",
                    "days": [
                        {"day": 1, "title": "Morning Flow", "workout": "Morning Flow"},
                        {"day": 2, "title": "Core & Balance", "workout": "Core & Balance"},
                        {"day": 3, "title": "Rest Day", "rest": True},
                        {"day": 4, "title": "Hip Opening", "workout": "Hip Opening Flow"},
                        {"day": 5, "title": "Morning Flow", "workout": "Morning Flow"},
                        {"day": 6, "title": "Rest Day", "rest": True},
                        {"day": 7, "title": "Full Body Restore", "workout": "Full Body Restore"},
                    ],
                },
                {
                    "week_number": 4, "title": "Week 4 — Integration",
                    "days": [
                        {"day": 1, "title": "Morning Flow", "workout": "Morning Flow"},
                        {"day": 2, "title": "Core & Balance", "workout": "Core & Balance"},
                        {"day": 3, "title": "Hip Opening", "workout": "Hip Opening Flow"},
                        {"day": 4, "title": "Rest Day", "rest": True},
                        {"day": 5, "title": "Morning Flow", "workout": "Morning Flow"},
                        {"day": 6, "title": "Full Body Restore", "workout": "Full Body Restore"},
                        {"day": 7, "title": "Rest & Celebrate", "rest": True},
                    ],
                },
            ],
        },
        {
            "title": "30-Day Flexibility Challenge",
            "description": "An intermediate 4-week programme to dramatically improve your flexibility. Progressive hip openers, backbends, and restorative flows.",
            "difficulty": "INTERMEDIATE",
            "duration_weeks": 4,
            "is_free": False,
            "ordering": 2,
            "weeks": [
                {
                    "week_number": w,
                    "title": f"Week {w} — {'Assess & Begin' if w == 1 else 'Deepen' if w == 2 else 'Challenge' if w == 3 else 'Transform'}",
                    "days": [
                        {"day": 1, "title": "Morning Flow", "workout": "Morning Flow"},
                        {"day": 2, "title": "Hip Opening", "workout": "Hip Opening Flow"},
                        {"day": 3, "title": "Core & Balance", "workout": "Core & Balance"},
                        {"day": 4, "title": "Rest Day", "rest": True},
                        {"day": 5, "title": "Full Body Restore", "workout": "Full Body Restore"},
                        {"day": 6, "title": "Hip Opening", "workout": "Hip Opening Flow"},
                        {"day": 7, "title": "Rest Day", "rest": True},
                    ],
                }
                for w in range(1, 5)
            ],
        },
    ],
}

# ---------------------------------------------------------------------------
# Posts per tenant
# ---------------------------------------------------------------------------
POSTS = {
    "iron-athletics": [
        {
            "title": "Welcome to Iron Athletics",
            "body": (
                "Welcome to **Iron Athletics** — your home for serious strength training.\n\n"
                "I'm Coach Marcus Steel, and I've built this platform to give you the same "
                "programming and guidance I use with my in-person athletes.\n\n"
                "## What to Expect\n\n"
                "- **Structured programmes** — from beginner to advanced powerlifting\n"
                "- **Video demos** — every exercise with proper form cues\n"
                "- **Progress tracking** — log your sets, reps, and weights\n\n"
                "Start with the **Strength Foundations** programme if you're new. Let's get strong."
            ),
            "is_published": True,
            "is_free": True,
        },
        {
            "title": "5 Tips for Your First Barbell Squat",
            "body": (
                "The barbell squat is the foundation of strength training. Here are five tips "
                "to get you started safely:\n\n"
                "1. **Start with just the bar** — learn the movement before adding weight\n"
                "2. **Feet shoulder-width apart** — toes slightly out\n"
                "3. **Brace your core** — big breath, tight midsection\n"
                "4. **Break at the hips first** — sit back, then down\n"
                "5. **Drive through your heels** — stand up with purpose\n\n"
                "Master these cues and you'll be squatting with confidence in no time."
            ),
            "is_published": True,
            "is_free": True,
        },
        {
            "title": "Progressive Overload: The Key to Getting Stronger",
            "body": (
                "If you're not progressively overloading, you're not getting stronger. "
                "It's that simple.\n\n"
                "## What Is Progressive Overload?\n\n"
                "It means gradually increasing the demands on your body over time. "
                "This can mean:\n\n"
                "- Adding weight to the bar\n"
                "- Doing more reps at the same weight\n"
                "- Adding an extra set\n"
                "- Reducing rest time between sets\n\n"
                "## How to Apply It\n\n"
                "Follow the programmes in this app — they're designed with built-in "
                "progression. Trust the process and track every workout."
            ),
            "is_published": True,
            "is_free": False,
        },
    ],
    "zen-fitness": [
        {
            "title": "Welcome to Zen Fitness",
            "body": (
                "Namaste and welcome to **Zen Fitness** — your space for mindful movement.\n\n"
                "I'm Aria Chen, and I created this app to make yoga accessible, enjoyable, "
                "and transformative — wherever you are.\n\n"
                "## Your Journey Starts Here\n\n"
                "- **Guided programmes** — from absolute beginner to intermediate flexibility\n"
                "- **Clear instructions** — every pose broken down step by step\n"
                "- **Track your practice** — build consistency and see your progress\n\n"
                "Roll out your mat and begin with **Yoga for Beginners**. See you on the mat."
            ),
            "is_published": True,
            "is_free": True,
        },
        {
            "title": "Why Flexibility Matters More Than You Think",
            "body": (
                "Flexibility isn't just about touching your toes. It's about freedom "
                "of movement, injury prevention, and quality of life.\n\n"
                "## Benefits of Regular Stretching\n\n"
                "- **Reduced injury risk** — flexible muscles are resilient muscles\n"
                "- **Better posture** — open hips and chest counteract desk life\n"
                "- **Less pain** — tight muscles cause aches; stretching releases them\n"
                "- **Mental clarity** — slow, mindful movement calms the nervous system\n\n"
                "Start with just 10 minutes a day. Your body will thank you."
            ),
            "is_published": True,
            "is_free": True,
        },
        {
            "title": "Building a Daily Yoga Habit",
            "body": (
                "Consistency beats intensity when it comes to yoga. Here's how to build "
                "a daily practice that sticks:\n\n"
                "1. **Start small** — 10 minutes is enough. Don't aim for 60 on day one.\n"
                "2. **Same time, same place** — anchor your practice to an existing habit\n"
                "3. **Don't skip rest days** — they're part of the practice\n"
                "4. **Track your sessions** — use this app to log every practice\n"
                "5. **Be kind to yourself** — some days the mat wins. That's okay.\n\n"
                "The **30-Day Flexibility Challenge** is designed to help you build "
                "this exact habit. Give it a try."
            ),
            "is_published": True,
            "is_free": False,
        },
    ],
}


class Command(BaseCommand):
    help = "Seed tenants with admin users, exercises, workouts, programs, and posts."

    def handle(self, *args, **options):
        group = self._ensure_tenant_admin_group()

        for tenant_data in TENANTS:
            tenant = self._seed_tenant(tenant_data)
            admin_user = self._seed_admin(tenant, group)
            exercises = self._seed_exercises(tenant)
            workouts = self._seed_workouts(tenant, exercises)
            self._seed_programs(tenant, workouts)
            self._seed_posts(tenant)

        self.stdout.write(self.style.SUCCESS("\nSeeding complete."))

    # ------------------------------------------------------------------
    # Tenant Admin permission group
    # ------------------------------------------------------------------
    def _ensure_tenant_admin_group(self):
        group, created = Group.objects.get_or_create(name="Tenant Admin")
        perms = []
        for app_label, model, actions in TENANT_ADMIN_PERMISSIONS:
            for action in actions:
                codename = f"{action}_{model}"
                try:
                    perms.append(
                        Permission.objects.get(
                            content_type__app_label=app_label,
                            codename=codename,
                        )
                    )
                except Permission.DoesNotExist:
                    self.stderr.write(
                        self.style.WARNING(f"  Permission not found: {app_label}.{codename}")
                    )
        group.permissions.set(perms)
        status = "Created" if created else "Updated"
        self.stdout.write(f"  [{status}] Group: Tenant Admin ({len(perms)} permissions)")
        return group

    # ------------------------------------------------------------------
    # Tenants
    # ------------------------------------------------------------------
    def _seed_tenant(self, data):
        slug = data["slug"]
        defaults = {k: v for k, v in data.items() if k != "slug"}
        tenant, created = Tenant.objects.get_or_create(slug=slug, defaults=defaults)
        status = "Created" if created else "Exists"
        self.stdout.write(f"  [{status}] Tenant: {tenant.name}")
        return tenant

    # ------------------------------------------------------------------
    # Admin users
    # ------------------------------------------------------------------
    def _seed_admin(self, tenant, group):
        info = ADMIN_USERS[tenant.slug]
        user, created = CustomUser.objects.get_or_create(
            email=info["email"],
            defaults={
                "first_name": info["first_name"],
                "last_name": info["last_name"],
                "tenant": tenant,
                "role": CustomUser.Role.ADMIN,
                "is_staff": True,
                "is_superuser": False,
            },
        )
        if created:
            user.set_password(info["password"])
            user.save(update_fields=["password"])
            self.stdout.write(self.style.SUCCESS(f"  [Created] Admin: {user.email}"))
        else:
            self.stdout.write(f"  [Exists]  Admin: {user.email}")

        # Add to Tenant Admin group (idempotent)
        user.groups.add(group)

        # Ensure tenant.owner is set
        if tenant.owner != user:
            tenant.owner = user
            tenant.save(update_fields=["owner"])

        return user

    # ------------------------------------------------------------------
    # Exercises
    # ------------------------------------------------------------------
    def _seed_exercises(self, tenant):
        exercises = {}
        for ex_data in EXERCISES[tenant.slug]:
            exercise, created = Exercise.objects.get_or_create(
                tenant=tenant,
                name=ex_data["name"],
                defaults={
                    "description": ex_data.get("description", ""),
                    "muscle_groups": ex_data.get("muscle_groups", []),
                    "equipment": ex_data.get("equipment", ""),
                    "instructions": ex_data.get("instructions", ""),
                },
            )
            exercises[exercise.name] = exercise
            status = "Created" if created else "Exists"
            self.stdout.write(f"    [{status}] Exercise: {exercise.name}")
        return exercises

    # ------------------------------------------------------------------
    # Workouts + ExerciseInWorkout
    # ------------------------------------------------------------------
    def _seed_workouts(self, tenant, exercises):
        workouts = {}
        for wo_data in WORKOUTS[tenant.slug]:
            workout, created = Workout.objects.get_or_create(
                tenant=tenant,
                title=wo_data["title"],
                defaults={
                    "description": wo_data.get("description", ""),
                    "estimated_duration_minutes": wo_data.get("estimated_duration_minutes", 0),
                },
            )
            workouts[workout.title] = workout
            status = "Created" if created else "Exists"
            self.stdout.write(f"    [{status}] Workout: {workout.title}")

            # Re-create exercise entries (handles re-runs cleanly)
            workout.exercise_entries.all().delete()
            for idx, entry in enumerate(wo_data["exercises"], start=1):
                ExerciseInWorkout.objects.create(
                    workout=workout,
                    exercise=exercises[entry["name"]],
                    ordering=idx,
                    sets=entry.get("sets", 3),
                    reps=entry.get("reps", "12"),
                    rest_seconds=entry.get("rest_seconds", 60),
                )
        return workouts

    # ------------------------------------------------------------------
    # Programs + Weeks + Days
    # ------------------------------------------------------------------
    def _seed_programs(self, tenant, workouts):
        for prog_data in PROGRAMS[tenant.slug]:
            program, created = Program.objects.get_or_create(
                tenant=tenant,
                title=prog_data["title"],
                defaults={
                    "description": prog_data.get("description", ""),
                    "difficulty": prog_data.get("difficulty", "BEGINNER"),
                    "duration_weeks": prog_data.get("duration_weeks", 4),
                    "is_free": prog_data.get("is_free", True),
                    "is_published": True,
                    "ordering": prog_data.get("ordering", 0),
                },
            )
            status = "Created" if created else "Exists"
            self.stdout.write(f"    [{status}] Program: {program.title}")

            # Re-create weeks and days (handles re-runs)
            program.weeks.all().delete()
            for week_data in prog_data["weeks"]:
                week = ProgramWeek.objects.create(
                    program=program,
                    week_number=week_data["week_number"],
                    title=week_data.get("title", ""),
                )
                for day_data in week_data["days"]:
                    is_rest = day_data.get("rest", False)
                    workout = None if is_rest else workouts.get(day_data.get("workout"))
                    ProgramDay.objects.create(
                        week=week,
                        day_number=day_data["day"],
                        title=day_data.get("title", ""),
                        workout=workout,
                        is_rest_day=is_rest,
                    )

    # ------------------------------------------------------------------
    # Posts
    # ------------------------------------------------------------------
    def _seed_posts(self, tenant):
        now = timezone.now()
        for i, post_data in enumerate(POSTS[tenant.slug]):
            post, created = Post.objects.get_or_create(
                tenant=tenant,
                title=post_data["title"],
                defaults={
                    "body": post_data["body"],
                    "is_published": post_data.get("is_published", False),
                    "is_free": post_data.get("is_free", True),
                    "published_at": now if post_data.get("is_published") else None,
                },
            )
            status = "Created" if created else "Exists"
            self.stdout.write(f"    [{status}] Post: {post.title}")
