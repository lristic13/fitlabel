import 'package:flutter/material.dart';

class AuthSwitchLink extends StatelessWidget {
  final String message;
  final String actionText;
  final VoidCallback onTap;

  const AuthSwitchLink({
    super.key,
    required this.message,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        TextButton(
          onPressed: onTap,
          child: Text(actionText),
        ),
      ],
    );
  }
}
