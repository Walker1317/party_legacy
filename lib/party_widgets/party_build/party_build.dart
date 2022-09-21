import 'package:flutter/material.dart';
import 'package:party/model/party.dart';
import 'package:party/party_widgets/party_build/widgets/avaliation_stars.dart';
import 'package:party/party_widgets/party_build/widgets/category_icon.dart';

class PartyBuild extends StatelessWidget {
  PartyBuild(this.party, {this.allWidth = false});
  Party party;
  bool allWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Navigator.pushNamed(context, '/partyDetails', arguments: party),
      child: Container(
        height: 140,
        width: allWidth == false ? 300 : null,
        margin: allWidth == false ? const EdgeInsets.fromLTRB(10, 0, 0, 20) : const EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(party.images[0]),
            fit: BoxFit.cover
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: 140,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black87,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(party.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),
                  ),
                  AvaliationStars(party)
                ],
              ),
            ),
            CategoryIcon(party.category)
          ],
        ),
      ),
    );
  }
}