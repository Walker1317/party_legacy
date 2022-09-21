import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:iconsax/iconsax.dart';
import 'package:localization/localization.dart';
import 'package:party/model/party.dart';
import 'package:party/party_widgets/empty_parties/empty_parties.dart';
import 'package:party/party_widgets/loading_state/party_build_loading.dart';
import 'package:party/party_widgets/party_build/party_build.dart';
import 'package:party/screens/widgets/party_icon.dart';

class StreamParty extends StatefulWidget {
  StreamParty(this.pageController, this.placemark);
  PageController pageController;
  Placemark placemark;

  @override
  _StreamPartyState createState() => _StreamPartyState();
}

class _StreamPartyState extends State<StreamParty> {
  final _controller = StreamController<QuerySnapshot>.broadcast();

  Future<Stream<QuerySnapshot>> _addListenerParty() async {

    if(widget.placemark != null){

      FirebaseFirestore db = FirebaseFirestore.instance;
      Stream<QuerySnapshot> stream = db.collection('parties',)
      .where('Type', isEqualTo: 'premium')
      .where('City', isEqualTo: widget.placemark.subAdministrativeArea)
      .orderBy('DateFilter', descending: true)
      .snapshots();
      

      stream.listen((dados){
        _controller.add(dados);
      });

    }

  }

  @override
  void initState() {
    super.initState();
    _addListenerParty();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _controller.stream,
      builder: (context, snapshot){
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Column(
              children: [
                PartyBuildLoading(
                  height: 20,
                  margin: const EdgeInsets.fromLTRB(10, 0, 150, 10),
                ),
                PartyBuildLoading(),
              ],
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:

            if(snapshot.hasError){
              return const Text('Erro ao carregar');
            }

            QuerySnapshot querySnapshot = snapshot.data;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                  child: Row(
                    children: [
                      PartyIcon(Iconsax.star),
                      const SizedBox(width: 10,),
                      Text('suggestions_for_you'.i18n(),
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),

                querySnapshot.docs.length < 1 ?

                EmptyParties(widget.pageController)
                
                :

                SizedBox(
                  height: 160,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: querySnapshot.docs.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, indice){

                      List<DocumentSnapshot> partys = querySnapshot.docs.toList();
                      DocumentSnapshot documentSnapshot = partys[indice];
                      Party party = Party.fromDocumentSnapshot(documentSnapshot);

                      return PartyBuild(party);

                    }
                  )
                ),
              ],
            );

        } return Container();
      }
    );
  }
}