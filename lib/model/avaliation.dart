
import 'package:cloud_firestore/cloud_firestore.dart';

class Avaliation {

  String _image;
  String _userId;
  String _name;
  String _date;
  String _message;
  num _avaliation;

  Avaliation.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.image = documentSnapshot['image'];
    this.userId = documentSnapshot['userId'];
    this.date = documentSnapshot['date'];
    this.message = documentSnapshot['message'];
    this.avaliation = documentSnapshot['avaliation'];
    this.name = documentSnapshot['name'];
  }

  Avaliation();

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "image" : this.image,
      "name" : this.name,
      "userId" : this.userId,
      "date" : this.date,
      "message" : this.message,
      "avaliation" : this.avaliation,
    };

    return map;

  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }
  
  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  num get avaliation => _avaliation;

  set avaliation(num value) {
    _avaliation = value;
  }

}