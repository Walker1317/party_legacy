
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:party/model/usuario.dart';

class AuthServices{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User _user;
  String errorText;

  signUpWithEmail(Usuario usuario, BuildContext context,) async{

    try {

      await _auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.pass
      ).then((_) async{
        
        print('sucesso ao cadastrar usuario');
        _user = _auth.currentUser;
        usuario.id = _user.uid;
        await _salvarDadosUsuario(usuario, context);
      });

    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          errorText = "email_in_use".i18n();
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          errorText = "operation_not_allowed".i18n();
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          errorText = "invalid_email".i18n();
          break;
        default:
          errorText = "login_error".i18n();
          break;
      }

      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Oops!'),
            content: Text(errorText),
            actions: [
              TextButton(
                onPressed: ()=> Navigator.of(context).pop(),
                child: const Text('OK'),
                )
            ],
          );
        });

    }
  }


  logarUsuario(Usuario usuario, BuildContext context,) async{
    try {

      await _auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.pass,
      ).then((_) => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false));

    } on FirebaseAuthException catch (e) {

      switch (e.code) {
        case "email-already-in-use":
          errorText = "email_in_use".i18n();
          break;
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          errorText = "incorrect_password".i18n();
          break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          errorText = "user_not_found".i18n();
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          errorText = "user_disabled".i18n();
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          errorText = "too_many_request".i18n();
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          errorText = "operation_not_allowed".i18n();
          break;
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          errorText = "invalid_email".i18n();
          break;
        default:
          errorText = "login_error".i18n();
          break;
      }

      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Oops!'),
            content: Text(errorText),
            actions: [
              TextButton(
                onPressed: ()=> Navigator.of(context).pop(),
                child: const Text('OK'),
                )
            ],
          );
        }
      );
    }
  }


  deslogarUsuario(BuildContext context,){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('are_you_sure'.i18n()),
          content: Text('envied_to_home'.i18n()),
          actions: [
            TextButton(
              onPressed: ()=> Navigator.of(context).pop(),
              child: Text('no'.i18n(), style: TextStyle(color: Colors.grey),),
            ),
            TextButton(
              onPressed: (){
                _auth.signOut().then((_)=> Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false));
              },
              child: Text('yes'.i18n(),  style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      });
  }


  _salvarDadosUsuario(Usuario usuario, BuildContext context){
    _user = _auth.currentUser;


    _db.collection('users')
    .doc(_user.uid)
    .set({

      "Id" : usuario.id,
      "Name": usuario.name,
      "E-mail" : usuario.email,
      "urlImage" : usuario.urlImage,
      "District" : usuario.district,
      "City" : usuario.city,
      "ZipCode" : usuario.zipCode,
      "State" : usuario.state,
      "Country" : usuario.country,
      "Verified" : usuario.verified,
      "UserType" : usuario.userType,

    }).then((_){

      print('Sucesso ao salvar dados do usuário');
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);

    }).catchError((e){

      print('Erro ao salvar dados do usuário');
      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Oops!'),
            content: Text('error_save_data'.i18n()),
            actions: [
              TextButton(
                onPressed: ()=> Navigator.of(context).pop(),
                child: const Text('OK'),
                )
            ],
          );
        });

    });

  }


}


class AuthException implements Exception {
  String message;

  AuthException(this.message);

}