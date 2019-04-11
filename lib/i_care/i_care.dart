import 'package:flutter/material.dart';
class ICarePage extends StatefulWidget {
  ICarePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ICarePageState createState() => _ICarePageState();
}

class _ICarePageState extends State<ICarePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          BoardWidget(),
          BoardWidget(),
        ],
      ),
    );
  }
}

class BoardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("健康指标", style: TextStyle(fontSize: 18.0),),
                Text("健康指标", style: TextStyle(fontSize: 12.0),),
              ],
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 1.618,
            children: <MetroWidget>[
              MetroWidget('体重'),
              MetroWidget('血糖'),
              MetroWidget('血压'),
              MetroWidget('运动步数'),
            ],
          ),
        ],
      ),
    );
  }

}
class MetroWidget extends StatelessWidget {
  final String title;
  const MetroWidget(this.title, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(
        "$title",
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
      decoration: BoxDecoration(

        gradient: LinearGradient(
          stops: [0.1, 0.5, 0.7, 0.9],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.lightBlue[800],
            Colors.lightBlue[700],
            Colors.lightBlue[400],
            Colors.lightBlue[200],
          ])
      ),
    );
  }
}