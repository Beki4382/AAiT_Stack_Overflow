import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/common.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyanAccent,
        appBar: AppBar(
          backgroundColor: Colors.grey,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        body: ListView(children: <Widget>[
          Stack(
            children: [
             CommonDecor(),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Column(children: [
                              DisplayText(
                                  'yuiopuihwoieruwoieruuihwoieru',
                                  25,
                                  FontWeight.bold,
                                  TextDecoration.none,
                                  Alignment.center),
                              DisplayText(
                                  'yuiopuihwoieruwoieruuihwoieru',
                                  25,
                                  FontWeight.bold,
                                  TextDecoration.none,
                                  Alignment.center),
                              DisplayText(
                                  'yuiopuihwoieruwoieruuihwoieru',
                                  25,
                                  FontWeight.bold,
                                  TextDecoration.none,
                                  Alignment.center),
                              Gap(0, 10),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 500,
                                  width: 750,
                                  child: Stack(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerRight,
                                        child: CircleAvatar(
                                          radius: 250,
                                          foregroundImage:
                                              AssetImage('asset/aa.jpg'),
                                        ),
                                      ),
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: CircleAvatar(
                                          radius: 250,
                                          foregroundImage:
                                              AssetImage('asset/qq.jpg'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(0, 10),
                              DisplayButton(50, 150,Alignment.center,  'Get Started',FontWeight.bold,25 )
                            ]),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )

              // Image(image: AssetImage('asset/question1.png'))
            ],
          ),
        ]),
      ),
    );
  }
}
