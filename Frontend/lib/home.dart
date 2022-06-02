import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String token;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsFlutterBinding.ensureInitialized();
    token = FlutterSession().get('token').toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(token);
    print('hey');
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Home Page")),
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                'Log in',
                style: TextStyle(fontSize: 30),
              )),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Sign up', style: TextStyle(fontSize: 30))),
          FutureBuilder<dynamic>(
              future: FlutterSession().get("token"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData && snapshot.data != '') {
                  print("token: " + snapshot.data);
                  return TextButton(
                      onPressed: () {
                        setState(() {
                          FlutterSession().set('token', '');
                        });
                      },
                      child: Text(
                        'Log out',
                        style: TextStyle(fontSize: 30),
                      ));
                } else if (snapshot.hasError) {
                  print(snapshot.data);
                  return Text(snapshot.error.toString());
           } else {
                  return TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'log in',
                        style: TextStyle(fontSize: 30),
                      ));
                }
              }),
        ],
      )),
    );
  }
}

