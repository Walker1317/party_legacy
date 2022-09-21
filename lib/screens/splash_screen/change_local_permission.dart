import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';

class ChangeLocalPermission extends StatelessWidget {
  const ChangeLocalPermission({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/partyBackground.jpg'),
          fit: BoxFit.cover
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.location_off_outlined, size: 120, color: Colors.white),
              const SizedBox(height: 40),
              Text('local_permission'.i18n(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 10),
              Text('local_permission1'.i18n(), style: const TextStyle(color: Colors.white,),),
              const SizedBox(height: 10),
              Text('local_permission2'.i18n(), style: const TextStyle(color: Colors.white,),),
              const SizedBox(height: 20,),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: ()=> Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Ionicons.reload_outline, color: Colors.black),
                      const SizedBox(width: 10,),
                      Text('check_again'.i18n(), style: const TextStyle(color: Colors.black,),),
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}