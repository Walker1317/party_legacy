
import 'package:cloud_firestore/cloud_firestore.dart';

class Event {

  String _id;
  String _idCreator;
  String _title;
  String _description;
  String _street;
  String _district;
  String _number;
  String _city;
  String _zipCode;
  String _state;
  String _country;
  String _image;
  String _date;
  String _time;
  bool _premium;
  String _premiumDate;
  String _createdAt;

  Event.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.id = documentSnapshot['Id'];
    this.idCreator = documentSnapshot['IdCreator'];
    this.title = documentSnapshot['Title'];
    this.description = documentSnapshot['Description'];
    this.district = documentSnapshot['District'];
    this.number = documentSnapshot['Number'];
    this.city = documentSnapshot['City'];
    this.zipCode = documentSnapshot['ZipCode'];
    this.state = documentSnapshot['State'];
    this.country = documentSnapshot['Country'];
    this.image = documentSnapshot['Image'];
    this.street = documentSnapshot['Street'];
    this.date = documentSnapshot['Date'];
    this.time = documentSnapshot['Time'];
    this.premium = documentSnapshot['Premium'];
    this.premiumDate = documentSnapshot['PremiumDate'];
    this.createdAt = documentSnapshot['CreatedAt'];
  }

  Event.gerarId(){

    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference party = db.collection("partys");
    this.id = party.doc().id;

  }

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "Id" : this.id,
      "IdCreator" : this.idCreator,
      "Street" : this.street,
      "Title" : this.title,
      "Description" : this.description,
      "District" : this.district,
      "City" : this.city,
      "ZipCode" : this.zipCode,
      "State" : this.state,
      "Country" : this.country,
      "Image" : this.image,
      "Number" : this.number,
      "Date" : this.date,
      "Time" : this.time,
      "Premium" : this.premium,
      "PremiumDate" : this.premiumDate,
      "CreatedAt" : this.createdAt,
    };

    return map;

  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get idCreator => _idCreator;

  set idCreator(String value) {
    _idCreator = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get street => _street;

  set street(String value) {
    _street = value;
  }

  String get district => _district;

  set district(String value) {
    _district = value;
  }

  String get number => _number;

  set number(String value) {
    _number = value;
  }

  String get city => _city;

  set city(String value) {
    _city = value;
  }

  String get zipCode => _zipCode;

  set zipCode(String value) {
    _zipCode = value;
  }

  String get state => _state;

  set state(String value) {
    _state = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  String get time => _time;

  set time(String value) {
    _time = value;
  }

  String get premiumDate => _premiumDate;

  set premiumDate(String value) {
    _premiumDate = value;
  }

  bool get premium => _premium;

  set premium(bool value) {
    _premium = value;
  }

  String get createdAt => _createdAt;

  set createdAt(String value) {
    _createdAt = value;
  }

}