import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user ?? loadUser() as User?;

  get isLoggedIn => _user?.token != null;

  Future<void> saveUser() async {
    print('chamou o saveUser');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(_user));
    print('User saved');
    print(prefs.getString('user'));
  }

  Future<User?> loadUser() async {
    print('user was loaded (or tryed)');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString('user');
    print('userString: $userString');
    if (userString != null && userString != 'null') {
      Map<String, dynamic> decodedUser = jsonDecode(userString);
      _user = User.fromMap(decodedUser);
      print('user decoded: ${jsonEncode(_user)}');
      return _user;
    }
    return null;
  }

  Future<void> logout() async {
    _user = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    notifyListeners();
    saveUser();
  }

  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("${dotenv.env['URL']}/login"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user': {
          'email': email,
          'password': password,
        },
      }),
    );

    if (response.statusCode == 200) {
      _user = User.fromLoginJson(
        jsonDecode(response.body)['status']['data']['user'],
        response.headers['authorization']!,
      );
      saveUser();
      return _user!;
    }
    if (response.statusCode == 401) {
      return Future.error('Unauthorized');
    } else {
      return Future.error('Failed to load User');
    }
  }
}
