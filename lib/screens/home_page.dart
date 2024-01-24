import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text('Home Page'),
          TextButton(
            onPressed: () {
              context.read<UserProvider>().logout();
              context.go('/');
            },
            child: Text('Logout'),
          )
        ],
      ),
    );
  }
}
