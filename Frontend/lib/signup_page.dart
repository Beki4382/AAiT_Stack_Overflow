import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login_theme.dart';
import 'models/user_model.dart';

class ErrorMessage {
  String message;
  ErrorMessage({required this.message});

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(
      message: json['message'] as String,
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 47, 198, 209),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          iconSize: 35.0,
          color: Colors.white,
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
      ),
      body: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var outlineInputBorder = OutlineInputBorder(
    gapPadding: 8,
    borderSide:
        const BorderSide(width: 1.2, color: Color.fromARGB(255, 9, 144, 153)),
    borderRadius: BorderRadius.circular(40),
  );
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _confirmPass = TextEditingController();

  Future save() async {
    http.Response response = await http.post(
        Uri.parse("http://localhost:3000/api/users/register"),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'name': user.name,
          'email': user.email,
          'password': user.password
        });
    if (response.statusCode == 200) {
      return "User registered successfully";
    } else {
      final Map<String, dynamic> data = json.decode(response.body);
      ErrorMessage errorMessage = ErrorMessage.fromJson(data);
      return errorMessage.message;
    }
  }

  User user = User('', '', '');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          // start .. container of header login text
          Container(
            margin:
                const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 5),
            alignment: Alignment.center,
            child: Text(
              "Create Account",
              style: LoginTheme.textTheme.headline1,
            ),
          ),

          // end .. container of header login text

          // start .. container of fill form text
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
            alignment: Alignment.center,
            child: Text(
              "Please fill the form below here",
              style: LoginTheme.textTheme.headline3,
            ),
          ),
          // end .. container of fill form text

          // inputtext fiel field for user name
          Container(
            margin:
                const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
            child: Column(children: [
              Container(
                height: 90,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: TextFormField(
                  controller: TextEditingController(text: user.name),
                  onChanged: (value) {
                    user.name = value;
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
                        Icons.person_outline,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    hintText: "Enter your Username",
                    hintStyle: LoginTheme.textTheme.headline4,
                    labelText: "Username",
                    labelStyle: LoginTheme.textTheme.headline3,
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Username can not be empty';
                    }
                    if (value.length < 5) {
                      return 'Username can not be less than 5 characters';
                    }

                    return null;
                  },
                ),
              ),

              // email input field
              Container(
                height: 90,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
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

                    if ((!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value))) {
                      return 'Please enter a valid Email';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                height: 90,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: TextFormField(
                  controller: TextEditingController(text: user.password),
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
              Container(
                height: 90,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: TextFormField(
                  controller: _confirmPass,
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
                    hintText: "Confirm your password",
                    hintStyle: LoginTheme.textTheme.headline4,
                    labelText: "Confirm Password",
                    labelStyle: LoginTheme.textTheme.headline3,
                  ),
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    if (value != user.password) {
                      return 'Password do not match.';
                    }
                    return null;
                  },
                ),
              ),
            ]),
          ),
          // start ...login button container
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 11, horizontal: 65),
                    primary:
                        const Color.fromARGB(255, 56, 231, 243), // background
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))
                    // foreground
                    ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // FutureBuilder<dynamic>(
                    //     future: save(),
                    //     builder:
                    //         (BuildContext context, AsyncSnapshot snapshot) {
                    //       if (snapshot.hasData) {
                    //         print(snapshot.data);
                    //         return Text(snapshot.data);
                    //       } else if (snapshot.hasError) {
                    //         print(snapshot.data);
                    //         return Text(snapshot.error.toString());
                    //       } else {
                    //         print(snapshot.data);
                    //         return const SizedBox(
                    //           width: 60,
                    //           height: 60,
                    //           child: CircularProgressIndicator(),
                    //         );
                    //       }
                    //     });
                    String message = await save();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          duration: Duration(seconds: 1),
                          backgroundColor: Color.fromARGB(124, 64, 245, 255)
                              .withOpacity(0.3),
                          content: Center(
                            heightFactor: 1.5,
                            child: Text(message,
                                style: const TextStyle(
                                    fontSize: 25, color: Colors.black)),
                          )),
                    );
                    if (message == "User registered successfully") {
                      Navigator.pushNamed(context, '/login');
                    }
                  }
                },
                child: Text("SignUp", style: LoginTheme.textTheme.headline1),
              )),

          // end ... login button container
          // Start  ... don't have an account
          // Start  ... don't have an account
          Container(
            margin: const EdgeInsets.only(bottom: 50, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: LoginTheme.textTheme.headline3),
                TextButton(
                    onPressed: () {
                      // Navigate to the second screen using a named route.
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      "Sign in",
                      style: LoginTheme.textTheme.headline5,
                    )),
              ],
            ),
          ),
          // end  ... don't have an account

          // end  ... don't have an account
        ],
      ),
    );
  }
}
