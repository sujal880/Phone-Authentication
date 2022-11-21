import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('HomeScreen'),
    ),
    body: Center(
      child: Text('Welcome',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
    ),
  );
  }

}