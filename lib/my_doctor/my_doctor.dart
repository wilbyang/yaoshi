import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaoshi/chat/chat.dart';
import 'package:yaoshi/common/models.dart';

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
      child: InkWell(
        onTap: () {
          Route route = MaterialPageRoute(builder: (context) => ChatPage(doctor));
          Navigator.push(context, route);
        },
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
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return DoctorTileWidget(Doctor.fromFireStoreDoc(document));
              }).toList(),
            );
        }
      },
    );
  }
}