import 'package:flutter/material.dart';

class ICareWidget extends StatelessWidget {
  final String title;
  ICareWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        BoardWidget("健康指标", "健康数据随手记"),
        BoardWidget("科学管理", "健康状况一目了然"),
      ],
    );
  }
}

class BoardWidget extends StatelessWidget {
  final String title;
  final String text2;
  const BoardWidget(
    this.title,
    this.text2, {
    Key key,
  }) : super(key: key);
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
                Text(
                  "$title",
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  "$text2",
                  style: TextStyle(fontSize: 12.0, color: Colors.black38),
                ),
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
  const MetroWidget(
    this.title, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(
        "$title",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [0.1, 0.5, 0.7, 0.9],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.lightBlue[700],
            Colors.lightBlue[600],
            Colors.lightBlue[400],
            Colors.lightBlue[200],
          ],
        ),
      ),
    );
  }
}
