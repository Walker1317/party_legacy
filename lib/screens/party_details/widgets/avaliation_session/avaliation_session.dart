import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:party/model/avaliation.dart';
import 'package:party/model/party.dart';
import 'package:party/screens/party_details/widgets/avaliation_session/avaliation_build.dart';
import 'package:party/screens/party_details/widgets/avaliation_session/new_avaliation.dart';

class AvaliationSession extends StatefulWidget {
  AvaliationSession(this.party);
  Party party;

  @override
  _AvaliationSessionState createState() => _AvaliationSessionState();
}

class _AvaliationSessionState extends State<AvaliationSession> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  bool _myAvaliation = false;
  Avaliation myAvaliation;
  User user;

  Future<Stream<QuerySnapshot>> _addListenerAvaliations() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
    .collection('parties')
    .doc(widget.party.id)
    .collection('avaliations')
    .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });

    _recoverUserAvaliation();
  }

  Future _recoverUserAvaliation() async{

    FirebaseAuth auth = FirebaseAuth.instance;
    User userA = auth.currentUser;
    FirebaseFirestore db = FirebaseFirestore.instance;

    if(user != null){

      user = userA;
      DocumentSnapshot snapshot = await db.collection('parties').doc(widget.party.id).collection('avaliations').doc(userA.uid).get();

      if(snapshot.exists == true){
        myAvaliation = Avaliation.fromDocumentSnapshot(snapshot);
        if(myAvaliation.userId != null){
          setState(() {
            _myAvaliation = true;
          });
        }
      }
    }

  }

  @override
  void initState() {
    super.initState();
    _addListenerAvaliations();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _controller.stream,
      builder: (context, snapshot){
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
            break;
          case ConnectionState.active:
          case ConnectionState.done:
    
            if(snapshot.hasError){
              return const Text('Erro ao carregar');
            }
    
            QuerySnapshot querySnapshot = snapshot.data;
    
            if(querySnapshot.docs.length == 0){
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Text('empty_avaliations'.i18n(), style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              );
            }
    
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                user == null ? Container() : _myAvaliation == true ? AvaliationBuild(myAvaliation, myAvaliation: _myAvaliation,) : NewAvaliation(widget.party),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: querySnapshot.docs.length <= 10 ? querySnapshot.docs.length : 10,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, indice){
    
                      List<DocumentSnapshot> avaliations = querySnapshot.docs.toList();
                      DocumentSnapshot documentSnapshot = avaliations[indice];
                      Avaliation avaliation = Avaliation.fromDocumentSnapshot(documentSnapshot);
    
                      return AvaliationBuild(avaliation);
    
                    }
                  ),
                ),
              ],
            );
    
        } return Container();
      }
    );
  }
}