import 'package:app/core/errors/failure.dart';
import 'package:app/features/user/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    Failure? failure = Provider.of<UserProvider>(context, listen: true).failure;
    ValidationFailure? validationFailure =
        failure is ValidationFailure ? failure : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                ),
                if (validationFailure?.fieldErrors["email"] != null)
                  Text(
                      style: const TextStyle(color: Colors.red),
                      validationFailure?.fieldErrors["email"]?[0] ?? ''),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
                if (validationFailure?.fieldErrors["password"] != null)
                  Text(
                      style: const TextStyle(color: Colors.red),
                      validationFailure?.fieldErrors["password"]?[0] ?? ''),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false)
                    .eitherFailureOrLogin(email: _email, password: _password);
              },
              child: const Text('Login'),
            ),
            if (failure != null) Text(failure.errorMessage),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: LoginScreen(),
  ));
}
