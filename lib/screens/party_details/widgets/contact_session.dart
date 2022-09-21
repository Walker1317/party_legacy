import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:party/model/party.dart';

class ContactSession extends StatelessWidget {
  ContactSession(this.party);
  Party party;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Ionicons.location_outline),
          title: Text('${party.street}, ${party.number} - ${party.district}'),
        ),
        ListTile(
          leading: Icon(Ionicons.locate_outline),
          title: Text('${party.city} / ${party.state}'),
        ),
      ],
    );
  }
}