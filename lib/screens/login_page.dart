import 'package:flutter/material.dart';
import '../widgets/login/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Card(
              color: theme.colorScheme.primary,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text('Access your profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimary,
                        )),
                    const SizedBox(height: 20),
                    const LoginForm(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
