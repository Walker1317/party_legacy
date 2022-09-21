import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:party/model/usuario.dart';
import 'package:party/screens/widgets/drawer/widgets/drawer_header.dart';
import 'package:party/screens/widgets/drawer/widgets/drawer_input_widgets.dart';

class DrawerComponents extends StatefulWidget {
  DrawerComponents(this.usuario, this.placemark);
  Usuario usuario;
  Placemark placemark;

  @override
  _DrawerComponentsState createState() => _DrawerComponentsState();
}

class _DrawerComponentsState extends State<DrawerComponents> {
  

  @override
  Widget build(BuildContext context) {

  return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 0),
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            children: [
              CustomDrawerHeader(widget.usuario, widget.placemark),
              const DrawerInputWidgets(),
              Container(
                height: 60,
                margin: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Alpha 0.0.1',
                  style: TextStyle(
                    color: Colors.grey[400]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

