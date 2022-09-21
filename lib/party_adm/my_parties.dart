import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:party/model/party.dart';
import 'package:party/model/usuario.dart';
import 'package:party/party_widgets/loading_state/party_build_loading.dart';
import 'package:party/party_widgets/party_build/party_build.dart';

class MyParties extends StatefulWidget {
  MyParties(this.usuario);
  Usuario usuario;

  @override
  State<MyParties> createState() => _MyPartiesState();
}

class _MyPartiesState extends State<MyParties> {
  Query queryParty;

  _addListenerMyParties(){

    queryParty = FirebaseFirestore.instance.collection('parties')
    .where('IdCreator', isEqualTo: widget.usuario.id)
    .orderBy('DateFilter', descending: true)
    .withConverter<Party>(fromFirestore: (snapshot, _)=> Party.fromDocumentSnapshot(snapshot),
    );

  }

  @override
  void initState() {
    super.initState();
    _addListenerMyParties();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              'Meus Estabelecimentos',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          FirestoreListView<Party>(
            physics: const BouncingScrollPhysics(),
            loadingBuilder: (context){
              return Column(
                children: [
                  PartyBuildLoading(),
                ],
              );
            },
            shrinkWrap: true,
            query: queryParty,
            pageSize: 15,
            itemBuilder: (context, snapshot){
    
              final party = snapshot.data();

              return PartyBuild(party, allWidth: true,);

            }
          ),
        ],
      ),
    );
  }
}