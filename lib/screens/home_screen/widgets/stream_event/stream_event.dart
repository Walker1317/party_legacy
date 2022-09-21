import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:iconsax/iconsax.dart';
import 'package:localization/localization.dart';
import 'package:party/event_widgets/empty_events/empty_events.dart';
import 'package:party/model/event.dart';
import 'package:party/event_widgets/event_build/event_build.dart';
import 'package:party/party_widgets/loading_state/party_build_loading.dart';
import 'package:party/screens/widgets/party_icon.dart';

class StreamEventsHome extends StatefulWidget {
  StreamEventsHome(this.pageController, this.placemark);
  PageController pageController;
  Placemark placemark;

  @override
  _StreamEventsHomeState createState() => _StreamEventsHomeState();
}

class _StreamEventsHomeState extends State<StreamEventsHome> {
  final _controller = StreamController<QuerySnapshot>.broadcast();

  Future<Stream<QuerySnapshot>> _addListenerEvent() async {

    if(widget.placemark != null){

      FirebaseFirestore db = FirebaseFirestore.instance;
      Stream<QuerySnapshot> stream = db.collection('events')
      .where('Premium', isEqualTo: true)
      .where('City', isEqualTo: widget.placemark.subAdministrativeArea)
      .orderBy('PremiumDate', descending: true)
      .snapshots();
      

      stream.listen((dados) {
        _controller.add(dados);
      });

    }

  }

  @override
  void initState() {
    super.initState();
    _addListenerEvent();
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
                PartyBuildLoading(height: 300,),
                PartyBuildLoading(
                  height: 20,
                  margin: const EdgeInsets.fromLTRB(10, 0, 150, 10),
                ),
                PartyBuildLoading(height: 300,),
              ],
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:

            if(snapshot.hasError){
              return const Text('Erro ao carregar');
            }

            QuerySnapshot querySnapshot = snapshot.data;

            return Flexible(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                    child: Row(
                      children: [
                        PartyIcon(Iconsax.calendar),
                        const SizedBox(width: 10,),
                        Text('events_near_you'.i18n(),
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                  querySnapshot.docs.length < 1 ?

                  EmptyEvents(widget.pageController)
                  
                  :
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: querySnapshot.docs.length <= 10 ? querySnapshot.docs.length : 10,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, indice){
            
                      List<DocumentSnapshot> events = querySnapshot.docs.toList();
                      DocumentSnapshot documentSnapshot = events[indice];
                      Event event = Event.fromDocumentSnapshot(documentSnapshot);
            
                      return EventBuild(event);
            
                    }
                  ),
                ],
              ),
            );

        } return Container();
      }
    );
  }
}