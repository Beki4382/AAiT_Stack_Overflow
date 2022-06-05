import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/common.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
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
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),
          backgroundColor: Colors.cyanAccent,
          body: ListView(
            children: <Widget>[
              Column(
                children: [
                  const CommonDecor(),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 460,
                      height: 800,
                      child: Column(
                        children: [
                          // const Center(
                          //   child: Text('Your Question here',
                          //       style: TextStyle(
                          //           fontSize: 20, fontWeight: FontWeight.bold)),
                          // ),
                          DisplayText('Your Question here', 20, FontWeight.bold,
                              TextDecoration.none, Alignment.center),
                          Gap(0, 10),
                          Center(
                            child: Column(
                              children: [
                                DisplayText('Title', 20, FontWeight.bold,TextDecoration.none,Alignment.topLeft),
                                Gap(0, 10),
                                DisplayTextField(400, 50, 5, 0, 20, 20, 1, 1, 'your title here', false),
                                Gap(0, 10),
                                DisplayText('Question', 20, FontWeight.bold, TextDecoration.none, Alignment.topLeft),
                                Gap(0, 10),
                                DisplayTextField(400, 200, 5, 0, 230, 230, 10, 1, 'your question here', false),
                                Gap(0, 10),
                                DisplayText('Tag', 20, FontWeight.bold, TextDecoration.none, Alignment.topLeft),
                                Gap(0, 10),
                                DisplayTextField(400, 50, 5, 0, 20, 20, 1, 1, 'question tag', false),
                              ],
                            ),
                          ),
                          Gap(0, 10),
                          DisplayButton(30, 100,Alignment.bottomRight,'Submit',FontWeight.normal,15)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
