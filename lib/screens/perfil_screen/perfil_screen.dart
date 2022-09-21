import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';
import 'package:party/model/usuario.dart';
import 'package:party/party_adm/my_parties.dart';
import 'package:party/screens/perfil_screen/widgets/owner_widgets/event_create.dart';
import 'package:party/screens/perfil_screen/widgets/owner_widgets/owner_create.dart';

class PerfilScreen extends StatefulWidget {
  PerfilScreen(this.usuario);
  Usuario usuario;

  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  String userType = "";
  IconData icon;

  _recoverUserType(){

    switch (widget.usuario.userType) {
      case 'Standard':
        userType = 'standard_usertype'.i18n();
        icon = Iconsax.user;
        break;
      case 'Owner':
        userType = 'owner_usertype'.i18n();
        icon = Ionicons.storefront_outline;
        break;
      case 'Artist':
        userType = 'artist_usertype'.i18n();
        icon = Ionicons.musical_notes_outline;
        break;
      default:
    }

    setState(() {
      userType;
      icon;
    });

  }

  @override
  void initState() {
    super.initState();
    _recoverUserType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/partyAppBar.jpg'),
              fit: BoxFit.cover
            ),
          ),
        ),
        title: Text('my_profile'.i18n()),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Ionicons.create_outline)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20,),
            CircleAvatar(
              radius: 70,
              backgroundImage: widget.usuario.urlImage != null ? NetworkImage(widget.usuario.urlImage) : null,
              backgroundColor: Colors.deepPurpleAccent[700],
              child: widget.usuario.urlImage != null ? null : const Icon(Ionicons.person_outline, size: 70, color: Colors.white,),
            ),
            const SizedBox(height: 20,),
            Text(
              widget.usuario.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800]
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.grey, size: 18,),
                const SizedBox(width: 5,),
                Text(
                  userType,
                  style: const TextStyle(
                    color: Colors.grey
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            widget.usuario.userType == 'Owner' ?
            OwnerCreateButton(widget.usuario): Container(),
            const SizedBox(height: 10,),
            EventCreateButton(widget.usuario),
            const SizedBox(height: 20,),
            widget.usuario.userType == 'Owner' ?
            MyParties(widget.usuario)
            : Container(),
            const Divider(),
            ListTile(
              onTap: ()=> Navigator.pushNamed(context, '/partyShop'),
              leading: const Icon(Ionicons.bag_handle_outline),
              title: const Text('Party Shop'),
            ),
            const Divider(),
            ListTile(
              onTap: (){},
              leading: const Icon(Ionicons.mail_outline),
              title: Text(widget.usuario.email),
            ),
            const Divider(),
            ListTile(
              onTap: (){},
              leading: const Icon(Ionicons.location_outline),
              title: Text('${widget.usuario.zipCode} - ${widget.usuario.city} / ${widget.usuario.state}'),
            ),
            const Divider(),
            ListTile(
              onTap: (){},
              leading: const Icon(Ionicons.locate_outline),
              title: Text(widget.usuario.country),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}