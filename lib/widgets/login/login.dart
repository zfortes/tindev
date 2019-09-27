import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tinder_dev/bloc/userBloc.dart';
import 'package:tinder_dev/model/user.dart';
import 'dart:convert';





class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);


  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final UserBloc bloc = BlocProvider.getBloc<UserBloc>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: CrossAxisAlignment.center,
        color: Colors.white,
        child: Center(
          child:Text(
            "teste"
          ),
        )
      ),

    );
  }


  void getUser() async{
    print("Entrou requisicao ================= ");
    final response =
        await http.post("http://10.0.2.2:3333/devs", headers: {'Content-type': 'application/json'},body: json.encoder.convert({"username":"zfortes"}));
    print("Saiu requisicao ================= ");
        var j =  json.decode(response.body);
        User user = User.fromJson(j);
        bloc.setUser(user);
        print(user.name);
        //print("J = " +  j);
  }
}