import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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