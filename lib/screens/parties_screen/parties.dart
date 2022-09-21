import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';
import 'package:party/model/party.dart';
import 'package:party/party_widgets/loading_state/party_build_loading.dart';
import 'package:party/party_widgets/party_build/party_build.dart';
import 'package:party/screens/parties_screen/stream_party.dart';
import 'package:party/screens/parties_screen/widgets/empty_parties_build.dart';
import 'package:party/screens/widgets/party_icon.dart';

class PartiesScreen extends StatefulWidget {
  PartiesScreen(this.placemark);
  Placemark placemark;

  @override
  State<PartiesScreen> createState() => _PartiesScreenState();
}

class _PartiesScreenState extends State<PartiesScreen> with AutomaticKeepAliveClientMixin<PartiesScreen>{
  Query queryParty;
  String filter = 'null';
  final _controller = StreamController<QuerySnapshot>.broadcast();

  _adicionarListenerParty(String filterS){
    if(filterS == null){
      setState(() {
        filter = 'null';
      });
    }

    if(filterS != filter){

      setState(() {
        if(filterS == null){
          filter = 'null';
        } else {
          filter = filterS;
        }
        queryParty = FirebaseFirestore.instance.collection('parties')
        .where('City', isEqualTo: widget.placemark.subAdministrativeArea)
        .where('Category', isEqualTo: filterS == 'null' ? null : filterS)
        .orderBy('DateFilter', descending: true)
        .withConverter<Party>(fromFirestore: (snapshot, _)=> Party.fromDocumentSnapshot(snapshot),
        );
      });

      Stream<QuerySnapshot> stream = queryParty.snapshots();
      stream.listen((dados) {
        _controller.add(dados);
      });

    }

  }

  @override
  void initState() {
    super.initState();
    _adicionarListenerParty(null);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 120,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                CategoryButton(Ionicons.list_outline, ()=> _adicionarListenerParty('null'), 'null', filter),
                CategoryButton(Icons.attractions_outlined, ()=> _adicionarListenerParty('attractions'), 'attractions', filter),
                CategoryButton(Ionicons.beer_outline, ()=> _adicionarListenerParty('bars'), 'bars', filter),
                CategoryButton(Icons.coffee, ()=> _adicionarListenerParty('coffee'), 'coffee', filter),
                CategoryButton(Ionicons.fast_food_outline, ()=> _adicionarListenerParty('fast_food'), 'fast_food', filter),
                CategoryButton(Icons.nightlife_rounded, ()=> _adicionarListenerParty('night_life'), 'night_life', filter),
                CategoryButton(Ionicons.pizza_outline, ()=> _adicionarListenerParty('pizzerias'), 'pizzerias', filter),
                CategoryButton(Ionicons.restaurant_outline, ()=> _adicionarListenerParty('restaurant'), 'restaurant', filter),
                CategoryButton(Icons.bookmark_outline, ()=> _adicionarListenerParty('others'), 'others', filter),
                const SizedBox(width: 10,),
              ],
            )
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              filter == 'null' ? 'all'.i18n() : filter.i18n(),
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),

          const Divider(),

          StreamParty(queryParty, _controller),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CategoryButton extends StatelessWidget {
  CategoryButton(this.icon, this.onPressed, this.filter, this.currentFilter);
  IconData icon;
  String filter;
  String currentFilter;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          filter == currentFilter ?
          Container(
            height: 85,
            width: 85,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.redAccent[400],
                  Colors.deepPurpleAccent[700],
                ]
              ),
            ),
          ) : Container(),
          SizedBox(
            height: 80,
            width: 80,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(
                ),
                primary: Colors.white,
                elevation: 5,
                onPrimary: Colors.grey[300],
                shadowColor: Colors.grey[100],
              ),
              child: PartyIcon(icon, size: 30,)
            ),
          ),
        ],
      ),
    );
  }
}