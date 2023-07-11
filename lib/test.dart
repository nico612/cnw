


import 'package:flutter/material.dart';

class HomeTest extends StatelessWidget {
  const HomeTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Home Test"),
        ),
        body: Container (
          // padding: EdgeInsets.all(10),
          child: TestWidget(),
          )
      ),
    );
  }
}

class TestWidget extends StatelessWidget {

  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      color: Colors.redAccent,
      child: Align(alignment: Alignment(0, 3.0),
      child: Container(
        width: 100,
        height: 100,
        color: Colors.blue,
      ),),
    );
  }
  

}