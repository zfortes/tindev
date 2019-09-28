

import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:tinder_dev/bloc/userBloc.dart';
import 'package:tinder_dev/model/user.dart';
import 'package:http/http.dart' as http;


List<User> userForMatch = new List<User>();

class Like extends StatefulWidget {
    Like({Key key, this.user}) : super(key: key);
    User user;
  _LikeState createState() => _LikeState();
}

class _LikeState extends State<Like> {
  final UserBloc bloc = BlocProvider.getBloc<UserBloc>();


  @override
  void initState() {
    // TODO: implement initState
    this.getUserForMatch();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child:  userForMatch.isEmpty ?
          Text("Acabou") :
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/logo.png'),
              SizedBox(height: 10,),
              UserCard(userMatch: userForMatch[0],),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RawMaterialButton(
                      onPressed: () {like();},
                      child: Image.asset('assets/dislike@2x.png'),
                      shape: new CircleBorder(),
                      elevation: 2.0,
                      fillColor: Colors.white,
                      padding: const EdgeInsets.all(15.0),
                    ),
                    SizedBox(width: 30,),
                    RawMaterialButton(
                      onPressed: () {dislike();},
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
        ),
    );
  }

  like(){

  }
  dislike(){

  }

  getUserForMatch() async {
    final response = await http.get("http://127.0.0.1:3333/devs",
      headers: {'Content-type': 'application/json', 'user': widget.user.id});
    var j = json.decode(response.body);
    print(j);
    List<User> users = new List<User>.from(j.map((i) => User.fromJson(i)).toList());
    setState(() {
      userForMatch = users;
    });
    //User user = User.fromJson(j);
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
                    child: Text(widget.userMatch.name, style: TextStyle(
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
                    child: Text(widget.userMatch.bio, style: TextStyle(
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




