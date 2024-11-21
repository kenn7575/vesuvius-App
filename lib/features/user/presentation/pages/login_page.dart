import 'package:app/data_theme.dart';
import 'package:app/features/user/presentation/widgets/login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.lightTheme,
      home: const Scaffold(
        body: Center(
          child: LoginScreen(),
        ),
      ),
    );
  }
}
