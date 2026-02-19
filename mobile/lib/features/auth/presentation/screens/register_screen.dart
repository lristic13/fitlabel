import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fitlabel/config/app_config.dart';
import 'package:fitlabel/core/errors/exceptions.dart';
import 'package:fitlabel/features/auth/presentation/providers/auth_provider.dart';
import 'package:fitlabel/features/auth/presentation/widgets/auth_error_banner.dart';
import 'package:fitlabel/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:fitlabel/features/auth/presentation/widgets/auth_switch_link.dart';
import 'package:fitlabel/features/auth/presentation/widgets/auth_text_field.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    ref.read(authNotifierProvider.notifier).register(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          tenantSlug: AppConfig.tenantSlug,
        );
  }

  String? _extractError(Object error) {
    if (error is ServerException) return error.message;
    if (error is NetworkException) return error.message;
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
                  Text(
                    'Create account',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start your fitness journey',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
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
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _passwordController,
                    label: 'Password',
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
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
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    obscureText: _obscureConfirm,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() => _obscureConfirm = !_obscureConfirm);
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  AuthSubmitButton(
                    label: 'Create Account',
                    isLoading: isLoading,
                    onPressed: _submit,
                  ),
                  const SizedBox(height: 16),
                  AuthSwitchLink(
                    message: 'Already have an account?',
                    actionText: 'Sign In',
                    onTap: () => context.go('/login'),
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
