import 'package:flutter/material.dart';
import '../const.dart';
class Loading extends StatelessWidget {
  const Loading();
  @override
  Widget build(BuildContext context)
  { return
    Scaffold(
      body: Center( child:
      CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(themeColor)
        , ), ), );
  }}