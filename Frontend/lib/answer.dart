import 'package:flutter/material.dart';
import 'package:flutter_ui/common.dart';

//

class AnswerPage extends StatelessWidget {
  const AnswerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
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
          backgroundColor: Colors.cyanAccent,
          body: Column(
            children: [
              CommonDecor(),
              Gap(0, 10),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 450,
                  height: 350,
                  child: Column(
                    children: [
                      DisplayText('Write your answer', 20, FontWeight.bold, TextDecoration.none, Alignment.center),
                     Gap(0, 10),
                      DisplayTextField(400, 250, 0, 0, 230, 230, 10, 10, 'here your answer',false),
                      Gap(0, 10),
                      DisplayButton(30, 100,Alignment.bottomRight, 'Send',FontWeight.normal,15)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
