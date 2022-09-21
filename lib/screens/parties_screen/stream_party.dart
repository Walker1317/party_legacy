import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:party/model/party.dart';
import 'package:party/party_widgets/loading_state/party_build_loading.dart';
import 'package:party/party_widgets/party_build/party_build.dart';
import 'package:party/screens/parties_screen/widgets/empty_parties_build.dart';

class StreamParty extends StatelessWidget {
  StreamParty(this.queryParty, this.streamController);
  Query queryParty;
  StreamController streamController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamController.stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
          case ConnectionState.done:
          default:

          QuerySnapshot querySnapshot = snapshot.data;

          if(querySnapshot != null){

            if(querySnapshot.docs.isEmpty){
              return const EmptyPartiesBuild();
            }
            
          }

          return Flexible(
            child: FirestoreListView<Party>(
              physics: const BouncingScrollPhysics(),
              loadingBuilder: (context){
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      PartyBuildLoading(),
                      PartyBuildLoading(),
                      PartyBuildLoading(),
                      PartyBuildLoading(),
                      PartyBuildLoading(),
                    ],
                  ),
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
          );
        }
      }
    );
  }
}