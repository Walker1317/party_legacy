import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:party/model/usuario.dart';
import 'package:party/screens/base_screen/base_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({this.onlyView = false});
  
  bool onlyView;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Usuario usuario;

  String error = '';

  _recoverGeolocator(BuildContext context){

    Future.delayed(const Duration(seconds: 1)).then((_) async{

      LocationPermission permission;

      bool activated = await Geolocator.isLocationServiceEnabled();
      if(!activated) {
        return Future.error('Por favor, habilite');
      }

      permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied){

        
        
        permission = await Geolocator.requestPermission();

        if(permission == LocationPermission.denied){

          Navigator.pushNamed(context, '/localPermission',);
          //return Future.error('Por favor, autorize');
          
        }
        
      }

      if(permission == LocationPermission.deniedForever) {
        Navigator.pushNamed(context, '/localPermission',);
      }

      try {
        
        Position position = await Geolocator.getLastKnownPosition();
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        
        Placemark placemark = placemarks[0];
        print(placemark.subAdministrativeArea);

        _verificarUsuario(context, placemark);

      } on Exception catch (e) {

        print(e);

      }
      
    });

  }

  _verificarUsuario(BuildContext context, Placemark placemark) async{

    FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser;

    if(user != null){

      _recuperarDadosUsuario(user.uid, context, placemark);

    } else {

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> BaseScreen(usuario, placemark)), (route) => false);

    }

  }

  _recuperarDadosUsuario(String userID, BuildContext context, Placemark placemark) async{
    print(userID);

    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await db.collection('users').doc(userID).get();

    usuario = Usuario.fromDocumentSnapshot(snapshot);

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> BaseScreen(usuario, placemark)), (route) => false);

  }

  @override
  void initState() {
    super.initState();
    _recoverGeolocator(context);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('images/partyBackground.jpg'),
          fit: BoxFit.cover
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/partySplash.png',
            fit: BoxFit.scaleDown,
            scale: 8,
          ),
          const SizedBox(height: 40,),
          const SpinKitSpinningLines(
            color: Colors.white,
            size: 100,
          ),
        ]
      ),
    );
  }
}