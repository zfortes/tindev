import 'package:flutter/material.dart';
import 'package:tinder_dev/widgets/login/login.dart';
import 'package:tinder_dev/widgets/main/main.dart';


class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  String user;


  @override
  Widget build(BuildContext context) {
    return Container(
       child: user == null ? Login() : Main(),
    );
  }
}