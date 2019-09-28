import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:tinder_dev/bloc/userBloc.dart';
import 'package:tinder_dev/widgets/login/login.dart';
import 'package:tinder_dev/widgets/main/like.dart';


class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  String user;
  final UserBloc bloc = BlocProvider.getBloc<UserBloc>();


  @override
  Widget build(BuildContext context) {
    return Container(
       child: StreamBuilder(
         stream: bloc.outUser,
         builder: (BuildContext context, AsyncSnapshot snapshot) {
           return snapshot.data == null ? Login() : Like(user: snapshot.data);
         },
       ),
    );
  }
}