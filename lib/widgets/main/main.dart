import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:tinder_dev/bloc/userBloc.dart';

class Main extends StatefulWidget {
  Main({Key key}) : super(key: key);

  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  final UserBloc bloc = BlocProvider.getBloc<UserBloc>();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder(
            stream: bloc.outUser,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Text('${snapshot.data}'),
                )
              );
          },
        )
    );
  }
}