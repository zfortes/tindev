import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(child: FlatButton(onPressed: () {getUser();}, child: Text("aperta"))),
    );
  }


  void getUser() async{
    final response =
        await http.post("http://localhost:3333/devs", headers: {'Content-type': 'application/json'},body: JSON.encoder.convert({"username":"zfortes"}));
        var j =  json.decode(response.body);
        print(j);
        //return "teste";
  }
}