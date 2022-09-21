import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:party/model/event.dart';
import 'package:party/model/usuario.dart';

class CreatePartyEvent{

  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  create(Usuario usuario, Event event, BuildContext context, File file) async{


    await _uploadImage(usuario, event, context, file);

  }

  Future _uploadImage(Usuario usuario, Event event, BuildContext context, File file) async {
    
    Reference pastaRaiz = storage.ref();
    Reference arquivo =
    pastaRaiz.child("events").child(event.id+".jpg");
 
    //Upload da imagem
    UploadTask task = arquivo.putFile(file);
 
    //Recuperar url da imagem
    task.then((TaskSnapshot snapshot) async{
      String url = await snapshot.ref.getDownloadURL();
      event.image = url;
      
      _uploadToFirestore(usuario, event, context, file);

    }).catchError((e){

      showDialog(
        context: context,
        builder: (BuildContext context){

          return AlertDialog(
            title: const Text('Oops!'),
            content: Text('error_save_data'.i18n()),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              )
            ],
          );

        }
      );

    });
  }

  _uploadToFirestore(Usuario usuario, Event event, BuildContext context, File file){

    db.collection('events').doc(event.id).set(event.toMap())
    .then((_){

      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      print('Sucesso ao criar evento');


    }).catchError((e){

      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder: (BuildContext context){

          return AlertDialog(
            title: const Text('Oops!'),
            content: Text('error_save_data'.i18n()),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: const Text('Ok'),
              )
            ],
          );

        }
      );

    });

  }

}