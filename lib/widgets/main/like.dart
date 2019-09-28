import 'dart:convert';




import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:tinder_dev/bloc/userBloc.dart';
import 'package:tinder_dev/model/user.dart';
import 'package:http/http.dart' as http;


class Like extends StatefulWidget {
  Like({Key key, this.user}) : super(key: key);
  User user;

  _LikeState createState() => _LikeState();
}

class _LikeState extends State<Like> {
  final UserBloc bloc = BlocProvider.getBloc<UserBloc>();
  List<User> userForMatch;
  bool listEmpyt;

  @override
  void initState() {
    // TODO: implement initState
    this.conect();
    this.initListEmpyt();
    this.getUserForMatch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: listEmpyt ?
        EndList() :
        Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                child: Image.asset('assets/logo.png'),
                padding: EdgeInsets.fromLTRB(0, 40, 0, 15),
              )
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10,),
                  UserCard(userMatch: userForMatch[0],),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RawMaterialButton(
                          onPressed: () {
                            dislike();
                          },
                          child: Image.asset('assets/dislike@2x.png'),
                          shape: new CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.white,
                          padding: const EdgeInsets.all(15.0),
                        ),
                        SizedBox(width: 30,),
                        RawMaterialButton(
                          onPressed: () {
                            like();
                          },
                          child: Image.asset('assets/like@2x.png'),
                          shape: new CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.white,
                          padding: const EdgeInsets.all(15.0),
                        ),
                      ],
                    )
                  )
                ])
            )
          ])
      ),
    );
  }

  like() async {
    if (userForMatch.length == 1) {
      setState(() {
        listEmpyt = true;
      });
    } else {
      setState(() {
        userForMatch.removeAt(0);
      });
    }
    final response = await http.post("http://127.0.0.1:3333/devs/${userForMatch[0].id}/likes", headers: {"user" : widget.user.id.toString()});


  }

  dislike() async{
    print("fora " + userForMatch.length.toString());
    if (userForMatch.length == 1) {
      print("ëntrou " + userForMatch.length.toString());
      setState(() {
        listEmpyt = true;
      });
    } else {
      setState(() {
        userForMatch.removeAt(0);
      });
    }

    final response = await http.post("http://127.0.0.1:3333/devs/${userForMatch[0].id}/dislikes", headers: {"user" : widget.user.id.toString()});
  }

  getUserForMatch() async {
    final response = await http.get("http://127.0.0.1:3333/devs",
      headers: {'Content-type': 'application/json', 'user': widget.user.id});
    var j = json.decode(response.body);
    //print(j);
    List<User> users = new List<User>.from(
      j.map((i) => User.fromJson(i)).toList());
    if (users.length > 0) {
      setState(() {
        userForMatch = users;
        listEmpyt = false;
      });
    }

    //User user = User.fromJson(j);
  }

  initListEmpyt() {
    setState(() {
      listEmpyt = true;
    });
  }

  conect() async {
//    IO.Socket socket = IO.io('http://localhost:3000');
//    socket.on('connect', (_) {
//      print('connect');
//      socket.emit('msg', 'test');
//    });
//    socket.on('event', (data) => print(data));
//    socket.on('disconnect', (_) => print('disconnect'));
//    socket.on('fromServer', (_) => print(_));
  }
}


class UserCard extends StatefulWidget {
  UserCard({Key key, this.userMatch}) : super(key: key);
  User userMatch;

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              width: 300,
              child: Image.network(
                widget.userMatch.avatar,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.userMatch.name != null
                    ? widget.userMatch.name
                    : "Desconhecido",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 20,),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.userMatch.bio != null ? widget.userMatch.bio : " ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,),
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}


class EndList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              child: Image.asset('assets/logo.png'),
              padding: EdgeInsets.fromLTRB(0, 40, 0, 15),
            )
          ),
          SizedBox(height: 200,),
          Container(child: Text('Acabou :(', style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 30),
          )
          )
        ],
      )
    );
  }
}





