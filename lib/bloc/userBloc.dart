
import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:tinder_dev/model/user.dart';

class UserBloc extends BlocBase {

  User user;


  var _userController = BehaviorSubject<dynamic>();
  Stream<dynamic> get outUser => _userController.stream;
  Sink<dynamic> get inUser => _userController.sink;
  dynamic get getUser => _userController.value;
  setUser(User user){
    inUser.add(user);
  }

  @override
  void dispose() {
    _userController.close();
    super.dispose();
  }
//
//// streams of Color
//  StreamController streamUserController = StreamController<User>.broadcast();
//// sink
//  Sink get userSink => streamUserController.sink;
//// stream
//  Stream<User> get userStream => streamUserController.stream;
//
//// function to change the color
//  setUser(User user) {
//    userSink.add(user);
//  }
//
//  @override
//  // TODO: implement initialState
//  get initialState => null;
//
//  @override
//  Stream mapEventToState(event) {
//    // TODO: implement mapEventToState
//    return null;
//  }
}