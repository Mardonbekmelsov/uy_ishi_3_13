import 'package:dars_3_9_uy_ishi/services/auth_http_service.dart';
import 'package:dars_3_9_uy_ishi/views/screens/login_screen.dart';
import 'package:dars_3_9_uy_ishi/views/screens/main_screen.dart';
import 'package:dars_3_9_uy_ishi/views/screens/manage_expense_screen.dart';
import 'package:dars_3_9_uy_ishi/views/screens/note_screen.dart';
import 'package:dars_3_9_uy_ishi/views/screens/settings_screen.dart';
import 'package:dars_3_9_uy_ishi/views/screens/signup_screen.dart';
import 'package:dars_3_9_uy_ishi/views/screens/todo_screens.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static bool loginCheck = true;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool("loginCheck") != null) {
      MyApp.loginCheck = sharedPreferences.getBool("loginCheck")!;
      setState(() {});
    }
    if (sharedPreferences.getString("expiryDate") != null) {
      DateTime box = DateTime.parse(sharedPreferences.getString("expiryDate")!);
      DateTime now = DateTime.now();
      if (box.isBefore(now)) {
        MyApp.loginCheck = true;
        AuthHttpServices.logout();
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/main": (context) => const MainScreen(),
        "/todo": (context) => const ToDoScreen(),
        "/note": (context) => const NoteScreen(),
        "/settings": (context) => const SettingsScreen(),
        "/manage": (context) => const ManageNoteScreen(),
        "/login": (context) => LoginScreen(),
        "/signUp": (context) => SignupScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: MyApp.loginCheck ? LoginScreen() : const MainScreen(),
    );
  }
}
