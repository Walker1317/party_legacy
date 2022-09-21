import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';
import 'package:party/model/usuario.dart';

class EventCreateButton extends StatelessWidget {
  EventCreateButton(this.usuario);
  Usuario usuario;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent[700],
        borderRadius: BorderRadius.circular(10)
      ),
      child: ElevatedButton(
        onPressed: ()=> Navigator.pushNamed(context, '/createEvent', arguments: usuario),
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Container(
          height: 35,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Iconsax.calendar),
              const SizedBox(width: 10,),
              Text('create_event'.i18n()),
            ],
          ),
        )
      ),
    );
  }
}