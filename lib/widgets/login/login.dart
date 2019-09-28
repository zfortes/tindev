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

    final myController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    @override

    @override
    Widget build(BuildContext context) {
        return Material(
            child: Container(
                color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Image.asset('assets/logo.png'),
                        SizedBox(height: 10,),


                        Container(
                            width: 308.0,
                            height: 60.0,
                            child: Card(
                                elevation: 3,
                                child: Form(
                                    key: _formKey,
                                    child: TextFormField(
                                        autofocus: false,
                                        controller: myController,
                                        keyboardType: TextInputType.text,
                                        onSaved: (value) {
                                            setState(() {

                                            });
                                        },
                                        validator: (value) {
                                            if (value.isEmpty) {
                                                return 'Digite um nome';
                                            }
                                            return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'Username',
                                            border: InputBorder.none,
                                            contentPadding: const EdgeInsets
                                                .symmetric(vertical: 15.0, horizontal: 15),
                                        ),
                                        style: TextStyle(fontSize: 20),
                                    ),
                                ),
                            ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                            width: 300.0,
                            height: 50,
                            child: RaisedButton(
                                elevation: 3,
                                color: Colors.orange,
                                child: Text(
                                    'Entrar',
                                    style: TextStyle(fontSize: 20, color: Colors.white)
                                ),
                                onPressed: (){
                                    if (_formKey.currentState.validate()) {
                                        getUser(myController.text);
                                        //Navigator.pop(context);
                                    }
                                },
                            )
                        ),
                    ],
                )
            )


        );
    }

    @override
    void dispose() {
        // Clean up the controller when the widget is disposed.
        myController.dispose();
        super.dispose();
    }


    void getUser(String userName) async {
        //final response = await http.post("http://10.0.2.2:3333/devs",
        final response = await http.post("http://127.0.0.1:3333/devs",
            headers: {'Content-type': 'application/json'},
            body: json.encoder.convert({"username": userName}));
        var j = json.decode(response.body);
        User user = User.fromJson(j);
        bloc.setUser(user);
        //print("J = " +  j);
    }
}