import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/models/token_model.dart';

import 'login_theme.dart';
import 'package:http/http.dart' as http;

import 'models/error_model.dart';
import 'models/user_model.dart';
import 'package:flutter_session/flutter_session.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();

  Future save() async {
    http.Response response = await http.post(
        Uri.parse("http://localhost:3000/api/users/login"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'email': user.email,
          'password': user.password
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      Token token = Token.fromJson(data);
      await FlutterSession().set('token', token.token);
      return "User logged in successfully";
    } else {
      final Map<String, dynamic> data = json.decode(response.body);
      ErrorMessage errorMessage = ErrorMessage.fromJson(data);
      return errorMessage.message;
    }
  }

  User user = User('', '', '');

  var outlineInputBorder = OutlineInputBorder(
    gapPadding: 8,
    borderSide:
        const BorderSide(width: 1.2, color: Color.fromARGB(255, 9, 144, 153)),
    borderRadius: BorderRadius.circular(40),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            ListView(children: <Widget>[
              // Start ... Image at head
              Container(
                constraints: BoxConstraints.expand(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                ),
                color: const Color.fromARGB(255, 56, 231, 243),
                child: const Image(
                    image: AssetImage('assets/stack8.png'),
                    fit: BoxFit.contain),
              ),
              // End ... Image at head

              // Start ... login header and fill text start
              Container(
                margin: const EdgeInsets.only(
                    left: 30, right: 30, top: 20, bottom: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Login", style: LoginTheme.textTheme.headline1),
                      Text(
                        "Please fill the form below here",
                        style: LoginTheme.textTheme.headline3,
                      ),

                      // End... login header and fill text start

                      // start.. form inputs email and password

                      Container(
                        height: 90,
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5),
                        child: TextFormField(
                          controller: TextEditingController(text: user.email),
                          onChanged: (value) {
                            user.email = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          showCursor: true,
                          style: LoginTheme.textTheme.headline2,
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(fontSize: 16),
                            border: outlineInputBorder,
                            focusedErrorBorder: outlineInputBorder,
                            errorBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 15, right: 5),
                              child: Icon(
                                Icons.email_outlined,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            hintText: "Enter your email account",
                            hintStyle: LoginTheme.textTheme.headline4,
                            labelText: "Email",
                            labelStyle: LoginTheme.textTheme.headline3,
                          ),
                          onSaved: (String? value) {},
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Email can not be empty';
                            }
                            if (value.length < 5) {
                              return 'Email can not be less than 5 characters';
                            }

                            if ((!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value))) {
                              return 'Please enter a valid Email';
                            }
                            return null;
                          },
                        ),
                      ),

                      // End.. form inputs email and password
                      Container(
                        height: 90,
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5),
                        child: TextFormField(
                          controller:
                              TextEditingController(text: user.password),
                          onChanged: (value) {
                            user.password = value;
                          },
                          obscureText: true,
                          showCursor: true,
                          style: LoginTheme.textTheme.headline2,
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(fontSize: 16),
                            border: outlineInputBorder,
                            focusedErrorBorder: outlineInputBorder,
                            errorBorder: outlineInputBorder,
                            focusedBorder: outlineInputBorder,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 15, right: 5),
                              child: Icon(
                                Icons.lock_outline_rounded,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            hintText: "Enter your Password",
                            hintStyle: LoginTheme.textTheme.headline4,
                            labelText: "Password",
                            labelStyle: LoginTheme.textTheme.headline3,
                          ),
                          onSaved: (String? value) {},
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Password can not be empty';
                            }
                            if (value.length < 5) {
                              return 'Password can not be less than 5 characters';
                            }
                            return null;
                          },
                        ),
                      ),

                      // start ...login button container
                      Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 11, horizontal: 65),
                                primary: const Color.fromARGB(
                                    255, 56, 231, 243), // background
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))
                                // foreground
                                ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                String message = await save();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration: Duration(seconds: 1),
                                      backgroundColor:
                                          Color.fromARGB(124, 64, 245, 255)
                                              .withOpacity(0.3),
                                      content: Center(
                                        heightFactor: 1.5,
                                        child: Text(message,
                                            style: const TextStyle(
                                                fontSize: 25,
                                                color: Colors.black)),
                                      )),
                                );
                                if (message == "User logged in successfully") {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/', (route) => false);
                                }
                              }
                            },
                            child: Text("Login",
                                style: LoginTheme.textTheme.headline1),
                          )),

                      // end ... login button container

                      // start ... forget password
                      Center(
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forget Password?",
                                style: LoginTheme.textTheme.headline5,
                              ))),
                    ]),
              ),
              // end ... forget password

              // Start  ... don't have an account
              Container(
                margin: const EdgeInsets.only(bottom: 50, top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                        style: LoginTheme.textTheme.headline3),
                    TextButton(
                        onPressed: () {
                          // Navigate to the second screen using a named route.
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          "Sign Up",
                          style: LoginTheme.textTheme.headline5,
                        )),
                  ],
                ),
              ),
              // end  ... don't have an account
            ]),
          ],
        ),
      ),
    );
  }
}
