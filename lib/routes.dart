import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neod_mobile/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'screens/login_page.dart';

// models
import 'models/user.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return FutureBuilder<User?>(
          future: context.read<UserProvider>().loadUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  Text('Error: ${snapshot.error}'),
                  TextButton(
                    onPressed: () {
                      context.read<UserProvider>().logout().then(
                            (v) => context.go('/'),
                          );
                    },
                    child: Text('Logout'),
                  ),
                ],
              );
            } else {
              final user = context.read<UserProvider>();
              if (user.isLoggedIn) {
                return HomePage();
              }
              print('user is not logged in');
              return LoginPage();
            }
          },
        );
      },
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) {
        return HomePage();
      },
    )
  ],
);
