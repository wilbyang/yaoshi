import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Doctor {
  final String name;
  final String title;
  final String major;
  final String resume;
  final String org;
  final String sector;
  Doctor({@required this.name, @required this.org, this.major, this.title,
    this.sector, this.resume});
  factory Doctor.fromFireStoreDoc(DocumentSnapshot doc) {
    return Doctor(name: doc['name'], title: doc["title"], org: doc['org'],
        major: doc["major"], resume: doc["resume"], sector: doc["sector"]);
  }
}


class Venue {
  final String title;
  final String teaser;
  final String poster;
  final List<Menu> menus;
  final List<MenuItem> menuItems;

  Venue({ @required this.poster, this.teaser, this.title, this.menus,this.menuItems});
  factory Venue.fromFireStoreDoc(DocumentSnapshot doc) {
    return Venue(title: doc["title"], poster: doc['poster'], teaser: doc["teaser"],
      menuItems: doc["menuItems"], menus: doc["menus"]
    );
  }
}



class Menu {
  final String title;
  Menu({@required this.title});
  factory Menu.fromFireStoreDoc(DocumentSnapshot doc) {
    return Menu(title: doc["title"]);
  }
}

enum MenuItemState {
  InStock,
  OutStock,
  Offline

}
class MenuItem {
  final String title;
  final double price;
  MenuItemState status = MenuItemState.InStock;
  MenuItem({@required this.title, @required this.price});
  factory MenuItem.fromFireStoreDoc(DocumentSnapshot doc) {
    return MenuItem(title: doc["title"]);
  }
}
class Category {
  final String title;
  final String poster;
  Category({ @required this.poster, @required this.title});
  factory Category.fromFireStoreDoc(DocumentSnapshot doc) {
    return Category(title: doc["title"], poster: doc['poster']);
  }
}

class Order {
  final Venue venue;
  final List<MenuItem> items;
  Order({ @required this.items, @required this.venue});
  factory Order.fromFireStoreDoc(DocumentSnapshot doc) {
    return Order(venue: doc["venue"], items: doc['items']);
  }
}