import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:localization/src/localization_extension.dart';
import 'package:party/model/usuario.dart';
import 'package:party/scripts/auth_services.dart';

class CustomDrawerHeader extends StatefulWidget {
  CustomDrawerHeader(this.usuario, this.placemark);
  Usuario usuario;
  Placemark placemark;

  @override
  _CustomDrawerHeaderState createState() => _CustomDrawerHeaderState();
}

class _CustomDrawerHeaderState extends State<CustomDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        widget.usuario != null ? 

        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/perfilScreen', arguments: widget.usuario);
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                const SizedBox(width: 20,),
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person_outline, size: 40,),
                ),
                const SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      //Máximo de 23 caracteres, mais que isso acusa overflow
                      widget.usuario.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    Row(
                      children: [
                        Text('view_profile'.i18n(), style: const TextStyle(color: Colors.white, fontSize: 12),),
                        Icon(Icons.chevron_right_sharp, color: Colors.redAccent[400], size: 16,),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )

        :

        GestureDetector(
          onTap: ()=> Navigator.pushNamed(context, '/signin'),
          child: Container(
            padding: const EdgeInsets.only(left: 40),
            color: Colors.transparent,
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('drawer_header'.i18n(), style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                Text('drawer_header2'.i18n(), style: const TextStyle(color: Colors.white, fontSize: 12,),),
              ],
            ),
          ),
        ),

        const SizedBox(height: 10,),
        const SizedBox(
          height: 30,
          child: Divider(
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 16,),
            const Icon(Icons.location_on, color: Colors.white),
            const SizedBox(width: 10,),
            Text('${widget.placemark.subAdministrativeArea} - ${widget.placemark.administrativeArea} / ${widget.placemark.isoCountryCode}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ],
        ),
        const SizedBox(
          height: 30,
          child: Divider(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}