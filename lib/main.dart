import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
      home: HomePage(title: '我的医生'),
    );
  }
}
class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentTab = 0;
  List<Widget> tabs = [
    MyDoctorList(),
    ICarePage(title: "我的健康数据",),
    StoreWidget(),
    ProfileWidget(),
  ];

  void _incrementCounter() {

  }
  void _onItemTapped(int index) {
    setState(() {
      _currentTab = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('我的医生')),
            BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('iCare')),
            BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('严选')),
            BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我')),
          ],
          currentIndex: _currentTab,
          unselectedItemColor: Colors.black38,
          selectedItemColor: Colors.blueAccent,
          onTap: _onItemTapped
      ),
      body: Center(
        child: tabs[_currentTab],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

