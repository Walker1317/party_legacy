
import 'package:cloud_firestore/cloud_firestore.dart';

class Party {

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
  String _category;
  List<dynamic> _images;
  String _createdAt;
  String _dateFilter;
  String _type;
  double _latitude;
  double _longitude;
  num _avaliations;
  num _stars;
  num _totalStars;

  Party.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
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
    this.images = documentSnapshot['Images'];
    this.street = documentSnapshot['Street'];
    this.avaliations = documentSnapshot['Avaliations'];
    this.stars = documentSnapshot['Stars'];
    this.category = documentSnapshot['Category'];
    this.totalStars = documentSnapshot['TotalStars'];
    this.createdAt = documentSnapshot['CreatedAt'];
    this.dateFilter = documentSnapshot['DateFilter'];
    this.type = documentSnapshot['Type'];
    this.latitude = documentSnapshot['Latitude'];
    this.longitude = documentSnapshot['Longitude'];
  }

  Party.gerarId(){

    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference party = db.collection("partys");
    this.id = party.doc().id;
    this.images = [];

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
      "Images" : this.images,
      "Number" : this.number,
      "Avaliations" : this.avaliations,
      "Stars" : this.stars,
      "Category" : this.category,
      "TotalStars" : this.totalStars,
      "CreatedAt" : this.createdAt,
      "DateFilter" : this.dateFilter,
      "Type" : this.type,
      "Latitude" : this.latitude,
      "Longitude" : this.longitude,
    };

    return map;

  }

  List<dynamic> get images => _images;

  set images(List<dynamic> value) {
    _images = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get idCreator => _idCreator;

  set idCreator(String value) {
    _idCreator = value;
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

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  String get createdAt => _createdAt;

  set createdAt(String value) {
    _createdAt = value;
  }

  String get dateFilter => _dateFilter;

  set dateFilter(String value) {
    _dateFilter = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  num get avaliations => _avaliations;

  set avaliations(num value) {
    _avaliations = value;
  }

  num get stars => _stars;

  set stars(num value) {
    _stars = value;
  }

  num get totalStars => _totalStars;

  set totalStars(num value) {
    _totalStars = value;
  }

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }

  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }

}