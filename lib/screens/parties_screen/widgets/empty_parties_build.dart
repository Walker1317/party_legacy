import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class EmptyPartiesBuild extends StatelessWidget {
  const EmptyPartiesBuild({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('images/partyBackground.jpg'),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.search_off_rounded, color: Colors.white, size: 60,),
          const SizedBox(height: 10,),
          Text('empty_parties3'.i18n(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
        ],
      ),
    );
  }
}