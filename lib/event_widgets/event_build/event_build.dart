import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';
import 'package:party/model/event.dart';

class EventBuild extends StatelessWidget {
  EventBuild(this.event);
  Event event;

  _recoverDate(BuildContext context){

    DateTime date = DateTime.parse(event.date);
    event.date = DateFormat(DateFormat.MONTH_DAY, 'locale'.i18n()).format(date).toString();

  }

  @override
  Widget build(BuildContext context) {

    _recoverDate(context);

    var premiumWidget = Container(
      height: 60,
      width: 30,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('images/partyBackground.jpg')),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
      ),
      child: const Icon(Ionicons.star_outline, color: Colors.white, size: 18,),
    );

    return GestureDetector(
      onTap: ()=> Navigator.pushNamed(context, '/eventDetails', arguments: event),
      child: Container(
        height: 300,
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              spreadRadius: 1,
              blurRadius: 20
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(event.image), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black26,
                      Colors.black,
                    ]
                  ),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Stack(
                  children: [
                    /*Positioned(
                      top: 0,
                      right: 20,
                      child: premiumWidget
                    ),*/
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          event.title,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.date, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800], fontSize: 24),),
                      Text(event.time, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),),
                    ],
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [
                          Colors.redAccent[400],
                          Colors.deepPurpleAccent[700]
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: ()=> Navigator.pushNamed(context, '/eventDetails', arguments: event),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)
                        ),
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 5,),
                          Text(
                            "check".i18n(),
                          ),
                          const SizedBox(width: 10,),
                          const Icon(Iconsax.arrow_right)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}