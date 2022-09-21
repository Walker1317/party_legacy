
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/src/localization_extension.dart';

class DrawerInputWidgets extends StatelessWidget {
  const DrawerInputWidgets({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          DrawerListTile(
            onPressed: (){},
            titulo: 'favorites'.i18n(),
            icon: Iconsax.heart,
          ),
          DrawerListTile(
            onPressed: (){},
            titulo: 'historic'.i18n(),
            icon: Iconsax.clock,
          ),
          DrawerListTile(
            onPressed: (){},
            titulo: 'schedule'.i18n(),
            icon: Iconsax.calendar,
          ),
          const SizedBox(
            height: 30,
            child: Divider(
              color: Colors.white,
            ),
          ),
          DrawerListTile(
            onPressed: (){},
            titulo: 'settings'.i18n(),
            icon: Ionicons.settings_outline,
          ),
          DrawerListTile(
            onPressed: (){},
            titulo: 'support'.i18n(),
            icon: Iconsax.info_circle,
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  DrawerListTile({this.titulo, this.icon, /*this.color,*/ @required this.onPressed});
  String titulo;
  IconData icon;
  //Color color;
  void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white,),
      title: Text(titulo, style: TextStyle(color: Colors.white),),
    );
  }
}