import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class MyDoctorPage extends StatefulWidget {
  MyDoctorPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyDoctorPageState createState() => _MyDoctorPageState();
}

class _MyDoctorPageState extends State<MyDoctorPage> {
  int _selectedIndex = 0;

  void _incrementCounter() {
    setState(() {
      _selectedIndex++;
    });
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.black38,
          selectedItemColor: Colors.blueAccent,
          onTap: _onItemTapped
      ),
      body: Center(
        child: MyDoctorList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
class Doctor {
  final String name;
  final String title;
  final String major;
  final String resume;
  final String org;
  final String sector;
  Doctor({@required this.name, @required this.org, this.major, this.title, this.sector, this.resume});
  factory Doctor.fromFireStoreDoc(DocumentSnapshot doc) {
    return Doctor(name: doc['name'], title: doc["title"], org: doc['org'], major: doc["major"], resume: doc["resume"], sector: doc["sector"]);
  }
}
class DoctorTileWidget extends StatelessWidget {

  final Doctor doctor;
  static const EdgeInsets textBottomEdgeInsets = const EdgeInsets.only(bottom: 8);
  const DoctorTileWidget(this.doctor, {
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 8, 32, 12),
      decoration: BoxDecoration(border: Border(
        bottom: BorderSide(color: Colors.black12)
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(right: 32, top: 8),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('http://i.imgur.com/QSev0hg.jpg'),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: textBottomEdgeInsets,
                      child: Text(
                        '${doctor.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Chip(
                      label: Text('问诊')
                    )
                  ],
                ),
                Container(
                  padding: textBottomEdgeInsets,
                  child: Text(
                    '${doctor.org}',
                  ),
                ),
                Text(
                  '${doctor.sector}, ${doctor.title}',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top:8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      HotIndexWidget("热度指数", 3),
                      Text("服务满意度 80%", style: TextStyle(fontSize: 10.0))
                    ],
                  ),
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}

class HotIndexWidget extends StatelessWidget {
  final String title;
  final int index;
  const HotIndexWidget(this.title, this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = List.filled(index, Icon(Icons.star, color: Colors.red[500], size: 12.0));

    return Row(
      children: <Widget>[
        Text("$title", style: TextStyle(fontSize: 10.0),)
      ]..addAll(list),
    );
  }
}

class MyDoctorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('doctors').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return DoctorTileWidget(Doctor.fromFireStoreDoc(document));
              }).toList(),
            );
        }
      },
    );
  }
}