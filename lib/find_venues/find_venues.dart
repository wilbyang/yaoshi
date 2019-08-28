import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaoshi/common/models.dart';
import 'package:yaoshi/near_venues/near_venues.dart';

class CategoryTileWidget extends StatelessWidget {
  final Category category;
  static const EdgeInsets textBottomEdgeInsets =
      const EdgeInsets.only(bottom: 8);

  const CategoryTileWidget(
    this.category, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 0, 6, 0),
      child: InkWell(
        onTap: () {
          Route route = MaterialPageRoute(builder: (context) => NearVenueList());
          Navigator.push(context, route);
        },
        child: Container(

          child: Stack(
            children: <Widget>[
              Image.network(category.poster),
              Center(
                child: Text(
                  '${category.title}',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VenueCategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('categories').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return Container(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
              child: GridView.count(
                crossAxisCount: 2,
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return CategoryTileWidget(Category.fromFireStoreDoc(document));
                }).toList(),
              ),
            );
        }
      },
    );
  }
}
