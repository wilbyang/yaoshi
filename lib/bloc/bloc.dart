import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum MusicControlOperation { stop, play, pause, next, previous }
typedef void OnError(Exception exception);

const Map<int, String> bottomNavTitles = {0: "餐厅", 1: "搜索", 2: "搜索", 3:"我的资料"};

class Bloc {
  Bloc() {
    bottomNavIndex.distinct().listen((index) {
      nextBottomNavTitle(bottomNavTitles[index]);
    });


    flash.listen((flash) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(flash),
        duration: Duration(seconds: 1),
      ));
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  BehaviorSubject<String> _bottomNavTitle = BehaviorSubject.seeded("");
  Stream<String> get bottomNavTitle => _bottomNavTitle.stream;
  Function(String) get nextBottomNavTitle => _bottomNavTitle.sink.add;

  BehaviorSubject<String> _flash = BehaviorSubject();
  Stream<String> get flash => _flash.stream;
  Function(String) get nextFlash => _flash.sink.add;

  BehaviorSubject<int> _bottomNavIndex = BehaviorSubject.seeded(0);
  Stream<int> get bottomNavIndex => _bottomNavIndex.stream.distinct();
  Function(int) get nextBottomNavIndex => _bottomNavIndex.sink.add;


//  Function(List<Music>) get changeMusics    => _musics.sink.add;
  void dispose() {
    _bottomNavTitle.close();
    _flash.close();
    _bottomNavIndex.close();
  }
}

class Provider extends InheritedWidget {
  final bloc = Bloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static Bloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}
