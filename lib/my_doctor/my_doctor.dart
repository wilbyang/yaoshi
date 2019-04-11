import 'package:flutter/material.dart';
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

  Widget _buildTitleSection(String title, String name) {

    const textBottomEdgeInsets = const EdgeInsets.only(bottom: 8);
    Widget titleSection = Container(
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
                        '$name',
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
                    '$title',
                  ),
                ),
                Text(
                  '肾内科, 主任医师',
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
    return titleSection;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        child: ListView(
          children: <Widget>[
            _buildTitleSection("武汉市中南湘雅同济医院", "张壮"),
            _buildTitleSection("北京协和医院", "刘洪波"),
            _buildTitleSection("解放军总医院", "常梦然"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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