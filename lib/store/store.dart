import 'package:flutter/material.dart';

class StoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("嘿嘿，这里是购物界面"),
      ],
    );
  }
}

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key key}) : super(key: key);
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(
      text: "LEFT",
      icon: Icon(Icons.add),
    ),
    Tab(
      text: "LEFT",
      icon: Icon(Icons.nature_people),
    ),
    Tab(
      text: "LEFT",
      icon: Icon(Icons.smoke_free),
    ),
    Tab(
      text: "LEFT",
      icon: Icon(Icons.accessibility),
    ),
    Tab(
      text: "LEFT",
      icon: Icon(Icons.add_location),
    ),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
        Container(

          child: TabBarView(
            controller: _tabController,
            children: myTabs.map((Tab tab) {
              return Center(child: Text(tab.text));
            }).toList(),
          ),
        ),
      ],
    );
  }
}
