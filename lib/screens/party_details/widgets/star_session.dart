import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:party/model/party.dart';
import 'package:party/screens/party_details/widgets/light_avaliation_stars.dart';

class StarSession extends StatelessWidget {
  StarSession(this.party);
  Party party;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LightAvaliationStars(party),
              Row(
                children: [
                  Text('${party.avaliations} ', style: TextStyle(color: Colors.grey, fontSize: 18),),
                  Text('avaliations'.i18n(), style: TextStyle(color: Colors.grey, fontSize: 18),),
                ],
              ),
            ],
          ),
          Text('${party.stars.toStringAsFixed(1)}', style: TextStyle(color: Colors.grey[800], fontSize: 30, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}