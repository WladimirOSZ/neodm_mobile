import 'package:flutter/material.dart';
import 'package:neod_mobile/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../form/build_form_field.dart';
import 'build_login_submit_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildFormFiled(
            hintText: 'Enter your e-mail',
            icon: Icon(Icons.email),
            controller: _emailController,
          ),
          const SizedBox(height: 20),
          BuildFormFiled(
            hintText: 'Enter your password',
            icon: Icon(Icons.lock),
            controller: _passwordController,
            obscureText: true,
          ),
          BuildLoginSubmitButton(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
            onSubmit: userProvider.login,
          ),
        ],
      ),
    );
  }
}
