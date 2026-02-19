import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fitlabel/features/auth/domain/models/user.dart';
import 'package:fitlabel/features/auth/presentation/providers/auth_provider.dart';
import 'package:fitlabel/features/auth/presentation/screens/login_screen.dart';
import 'package:fitlabel/features/auth/presentation/screens/register_screen.dart';
import 'package:fitlabel/app/shell_screen.dart';
import 'package:fitlabel/features/programs/presentation/screens/programs_screen.dart';
import 'package:fitlabel/features/programs/presentation/screens/program_detail_screen.dart';
import 'package:fitlabel/features/workouts/presentation/screens/workouts_screen.dart';
import 'package:fitlabel/features/workouts/presentation/screens/workout_detail_screen.dart';
import 'package:fitlabel/features/profile/presentation/screens/profile_screen.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/programs',
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull is User;
      final isAuthRoute =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!isLoggedIn && !isAuthRoute) return '/login';
      if (isLoggedIn && isAuthRoute) return '/programs';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => ShellScreen(child: child),
        routes: [
          GoRoute(
            path: '/programs',
            builder: (context, state) => const ProgramsScreen(),
            routes: [
              GoRoute(
                path: ':id',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => ProgramDetailScreen(
                  programId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/workouts',
            builder: (context, state) => const WorkoutsScreen(),
            routes: [
              GoRoute(
                path: ':id',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => WorkoutDetailScreen(
                  workoutId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  );
}
