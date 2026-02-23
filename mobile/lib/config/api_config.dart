class ApiConfig {
  // Android emulator: 'http://10.0.2.2:8000'
  // iOS simulator / macOS: 'http://localhost:8000'
  static const String baseUrl = 'http://localhost:8000';

  // Auth
  static const String login = '/v1/auth/login/';
  static const String register = '/v1/auth/register/';
  static const String tokenRefresh = '/v1/auth/token/refresh/';
  static const String me = '/v1/auth/me/';
  static const String passwordReset = '/v1/auth/password/reset/';
  static const String passwordConfirm = '/v1/auth/password/confirm/';

  // Config
  static const String tenantConfig = '/v1/config/';

  // Programs
  static const String programs = '/v1/programs/';
  static String programDetail(String id) => '/v1/programs/$id/';
  static String programEnroll(String id) => '/v1/programs/$id/enroll/';
  static String programProgress(String id) => '/v1/programs/$id/progress/';

  // Workouts
  static const String workouts = '/v1/workouts/';
  static String workoutDetail(String id) => '/v1/workouts/$id/';
  static String workoutStart(String id) => '/v1/workouts/$id/start/';
  static String workoutComplete(String id) => '/v1/workouts/$id/complete/';

  // Exercises
  static const String exercises = '/v1/exercises/';
  static const String muscleGroups = '/v1/exercises/muscle-groups/';
  static String exerciseDetail(String id) => '/v1/exercises/$id/';

  // Content
  static const String posts = '/v1/content/posts/';
  static String postDetail(String id) => '/v1/content/posts/$id/';

  // Progress
  static const String progressHistory = '/v1/progress/history/';
  static const String progressStats = '/v1/progress/stats/';
}
