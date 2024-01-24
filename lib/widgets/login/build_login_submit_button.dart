import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/user.dart';

class BuildLoginSubmitButton extends StatelessWidget {
  const BuildLoginSubmitButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textButtonStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 20,
    );
    final buttonStyle = ElevatedButton.styleFrom(
      textStyle: textButtonStyle,
      backgroundColor: Color.fromARGB(255, 153, 227, 153),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
    final scaffold = ScaffoldMessenger.of(context);

    return Padding(
      padding: const EdgeInsets.all(30),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              scaffold.hideCurrentSnackBar();

              scaffold.showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
              Future<User> response = onSubmit(
                emailController.text,
                passwordController.text,
              );

              response.then((user) {
                scaffold.hideCurrentSnackBar();
                scaffold.showSnackBar(
                  SnackBar(
                    content: Text('Welcome ${user.email}'),
                    backgroundColor: Colors.green,
                  ),
                );

                context.goNamed('home');
              }).catchError((error) {
                print('error: $error');
                scaffold.hideCurrentSnackBar();
                scaffold.showSnackBar(
                  SnackBar(
                    content: Text(error.toString()),
                    backgroundColor: Colors.red,
                  ),
                );
              });
            }
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
