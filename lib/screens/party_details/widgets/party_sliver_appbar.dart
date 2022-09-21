import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:party/model/party.dart';

class PartySliverAppBar extends StatelessWidget {
  PartySliverAppBar(this.party);
  Party party;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(party.images[0],),
            fit: BoxFit.cover,
            ),
          ),
          child: Container(
            height: 300,
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black87,
                ],
              ), 
            ),
          ),
        ),
        //titlePadding: const EdgeInsetsDirectional.only(start: 20, bottom: 20),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${party.title}', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
            Text('${party.category}'.i18n(), style: const TextStyle(color: Colors.white70, fontSize: 10),),
          ],
        ),
      ),
    );
  }
}