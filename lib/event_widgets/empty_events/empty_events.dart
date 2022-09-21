import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';

class EmptyEvents extends StatelessWidget {
  EmptyEvents(this.pageController);
  PageController pageController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        pageController.animateToPage(3, duration: const Duration(milliseconds: 300), curve: Curves.ease);
      },
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage('images/partyBackground1.jpg'),
            fit: BoxFit.cover
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('events'.i18n()),
                        content: Text('empty_events1'.i18n()),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        actions: [
                          TextButton(
                            onPressed: ()=> Navigator.of(context).pop(),
                            child: const Text("OK")
                          ),
                        ],
                      );
                    }
                  );
                },
                icon: const Icon(Ionicons.information_circle_outline, color: Colors.white,)
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Ionicons.calendar_outline, size: 40, color: Colors.white),
                  const SizedBox(height: 20,),
                  Text('empty_events2'.i18n(), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold), textAlign: TextAlign.justify,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}