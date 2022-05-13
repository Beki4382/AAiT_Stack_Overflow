import 'package:flutter/material.dart';
import 'package:project/home.dart';
import 'loginpage.dart';
import 'signup_page.dart';

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => const LogInScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/register': (context) => const SignUpPage(),
      },
      title: "Log in Page",
      debugShowCheckedModeBanner: false,
    );
  }
}
