import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:party/model/local.dart';

class Usuario {

  String _id;
  String _name;
  String _email;
  String _pass;
  String _urlImage;
  String _district;
  String _city;
  String _zipCode;
  String _state;
  String _country;
  String _userType;
  String _partyId;
  bool _verified;
  Local _local;

  Usuario.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.id = documentSnapshot['Id'];
    this.name = documentSnapshot['Name'];
    this.partyId = documentSnapshot['PartyID'];
    this.email = documentSnapshot['E-mail'];
    this.urlImage = documentSnapshot['urlImage'];
    this.district = documentSnapshot['District'];
    this.city = documentSnapshot['City'];
    this.zipCode = documentSnapshot['ZipCode'];
    this.state = documentSnapshot['State'];
    this.country = documentSnapshot['Country'];
    this.verified = documentSnapshot['Verified'];
    this.userType = documentSnapshot['UserType'];

  }

  Usuario();

  Map<String, dynamic> toMap(){

    Map<String, dynamic> map = {
      "Id" : this.id,
      "PartyID" : this.partyId,
      "Name": this.name,
      "E-mail" : this.email,
      "urlImage" : this.urlImage,
      "District" : this.district,
      "City" : this.city,
      "ZipCode" : this.zipCode,
      "State" : this.state,
      "Country" : this.country,
      "Verified" : this.verified,
      "UserType" : this.userType,
    };

    return map;

  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get partyId => _partyId;

  set partyId(String value) {
    _partyId = value;
  }


  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get pass => _pass;

  set pass(String value) {
    _pass = value;
  }

  String get urlImage => _urlImage;

  set urlImage(String value) {
    _urlImage = value;
  }

  String get district => _district;

  set district(String value) {
    _district = value;
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

  String get userType => _userType;

  set userType(String value) {
    _userType = value;
  }

  bool get verified => _verified;

  set verified(bool value) {
    _verified = value;
  }

  Local get local => _local;

  set local(Local value) {
    _local = value;
  }
  
}