import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yaoshi/common/models.dart';

class VenueWidget extends StatelessWidget {
  final Venue venue;

  const VenueWidget(
    this.venue, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(venue.poster),
              title: Text('${venue.title}'),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: Text('grid item $index'),
                );
              },
              childCount: 20,
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('list item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItemTile extends StatelessWidget {
  final Venue venue;
  static EdgeInsets textBottomEdgeInsets =
      EdgeInsets.only(bottom: 8);

  MenuItemTile(
    this.venue, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 8, 32, 12),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12))),
      child: InkWell(
          onTap: () {
            Route route = MaterialPageRoute(builder: (context) => null);
            Navigator.push(context, route);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.network(venue.poster),
              Text(
                '${venue.title}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              Text('${venue.teaser}'),
            ],
          )),
    );
  }
}
