import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaoshi/chat/chat.dart';
import 'package:yaoshi/common/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yaoshi/venue_specific/venue_specific.dart';
class VenueTileWidget extends StatelessWidget {
  final Venue venue;
  static const EdgeInsets textBottomEdgeInsets = const EdgeInsets.only(bottom: 8);
  const VenueTileWidget(this.venue, {
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double sideLength = 50;

/*      return Center(
        child: AnimatedContainer(
          height: sideLength,
          width: sideLength,
          duration: Duration(seconds: 2),
          curve: Curves.easeIn,
          child: Material(
            color: Colors.yellow,
            child: InkWell(
              onTap: () {
                Route route = MaterialPageRoute(builder: (context) => VenueWidget());
                Navigator.push(context, route);
              },
            ),
          ),
        ),
      );*/
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 8, 32, 12),
      decoration: BoxDecoration(border: Border(
          bottom: BorderSide(color: Colors.black12)
      )),
      child: InkWell(
        onTap: () {
          Route route = MaterialPageRoute(builder: (context) => VenueWidget(venue));
          Navigator.push(context, route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Image.network(venue.poster),
            Text('${venue.title}', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0
            ),),
            Text('${venue.teaser}'),

          ],
        )
      ),
    );
  }
}

class NearVenueList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('venues').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return VenueTileWidget(Venue.fromFireStoreDoc(document));
              }).toList(),
            );
        }
      },
    ),);
    /*return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('venues').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return VenueTileWidget(Venue.fromFireStoreDoc(document));
              }).toList(),
            );
        }
      },
    );*/
  }
}