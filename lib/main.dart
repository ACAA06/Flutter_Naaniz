import 'package:flutter/material.dart';
import 'package:flutternaaniz/Home.dart';
import 'const.dart';

void main() {
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
    },
  ));}
