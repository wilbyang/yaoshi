import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yaoshi/bloc/bloc.dart';
import 'package:yaoshi/i_care/i_care.dart';
import 'package:yaoshi/my_doctor/my_doctor.dart';
import 'package:yaoshi/profile/profile.dart';
import 'package:yaoshi/store/store.dart';

void main() => runApp(MyApp());
final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: Provider(
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: StreamBuilder<String>(
          stream: bloc.bottomNavTitle,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data);
            }
            return Text("");
          },
        ),
      ),
      bottomNavigationBar: StreamBuilder<int>(
        stream: bloc.bottomNavIndex,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('我的医生')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), title: Text('iCare')),
              BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('严选')),
              BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我')),
            ],
            currentIndex: snapshot.data??0,
            unselectedItemColor: Colors.black38,
            selectedItemColor: Colors.blueAccent,
            onTap: bloc.nextBottomNavIndex,
          );
        }
      ),
      body: StreamBuilder<int>(
        stream: bloc.bottomNavIndex,
        builder: (context, snapshot) {
          Widget widget = Container(width: 0.0, height: 0.0,);
          if (snapshot.hasData) {
            switch (snapshot.data) {
              case 0:
                widget = MyDoctorList();
                break;
              case 1:
                widget = ICareWidget();
                break;
              case 2:
                widget = StoreWidget();
                break;
              case 3:
                widget = ProfileWidget();
                break;
            }
          }
          return Center(
            child: widget,
          );
        },
      ),
    );
  }
}

