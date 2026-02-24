import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fitlabel/core/errors/exceptions.dart';
import 'package:fitlabel/features/auth/presentation/providers/auth_provider.dart';
import 'package:fitlabel/features/auth/presentation/widgets/auth_error_banner.dart';
import 'package:fitlabel/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:fitlabel/features/auth/presentation/widgets/auth_switch_link.dart';
import 'package:fitlabel/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:fitlabel/shared/widgets/tenant_logo.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    ref.read(authNotifierProvider.notifier).login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  String? _extractError(Object error) {
    if (error is ServerException) return error.message;
    if (error is NetworkException) return error.message;
    if (error is UnauthorizedException) return 'Invalid email or password';
    return 'Something went wrong';
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AsyncLoading;
    final error = authState.hasError ? _extractError(authState.error!) : null;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(child: TenantLogo(size: 64)),
                  const SizedBox(height: 24),
                  Text(
                    'Welcome back',
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to your account',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  if (error != null) ...[
                    AuthErrorBanner(message: error),
                    const SizedBox(height: 16),
                  ],
                  AuthTextField(
                    controller: _emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      if (!value.contains('@')) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  AuthTextField(
                    controller: _passwordController,
                    label: 'Password',
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  AuthSubmitButton(
                    label: 'Sign In',
                    isLoading: isLoading,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: 16),
                  AuthSwitchLink(
                    message: "Don't have an account?",
                    actionText: 'Register',
                    onTap: () => context.go('/register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
