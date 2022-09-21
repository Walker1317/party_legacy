import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';
import 'package:party/model/party.dart';
import 'package:party/screens/parties_screen/stream_party.dart';

class TrendingScreen extends StatefulWidget {
  TrendingScreen(this.placemark);
  Placemark placemark;

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> with AutomaticKeepAliveClientMixin<TrendingScreen>{
  Query queryParty;
  final _controller = StreamController<QuerySnapshot>.broadcast();

  _adicionarListenerParty(){

    queryParty = FirebaseFirestore.instance.collection('parties')
    .where('City', isEqualTo: widget.placemark.subAdministrativeArea)
    .orderBy('DateFilter', descending: true)
    .withConverter<Party>(fromFirestore: (snapshot, _)=> Party.fromDocumentSnapshot(snapshot),
    );

    Stream<QuerySnapshot> stream = queryParty.snapshots();
    stream.listen((dados) {
      _controller.add(dados);
    });

  }

  @override
  void initState() {
    super.initState();
    _adicionarListenerParty();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Row(
              children: [
                Icon(Icons.local_fire_department_outlined, color: Colors.amber[800], size: 32,),
                const SizedBox(width: 10,),
                Text(
                  'trending'.i18n(),
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
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