import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Local {

  double _lat;
  double _long;
  GoogleMapController _mapsController;

  Local();

  double get lat => _lat;

  set lat(double value) {
    _lat = value;
  }

  double get long => _long;

  set long(double value) {
    _long = value;
  }

  GoogleMapController get mapsController => _mapsController;

  set mapsController(GoogleMapController value) {
    _mapsController = value;
  }

  getPosition() async{

    _posicaoAtual().then((value) async{

      Position position = await _posicaoAtual();
      _lat = position.latitude;
      _long = position.longitude;

    }).catchError((e){

      print(e);

    });

  }

  Future<Position> _posicaoAtual() async{

    LocationPermission permission;

    bool active = await Geolocator.isLocationServiceEnabled();
    if(! active){
      return Future.error('Por favor, habilite a localização no smartphone');
    }

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      return Future.error('Voce precisa autorizar o acesso à localização');
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error('Você precisa autorizar o acesso a localização');
    }

    return await Geolocator.getCurrentPosition();

  }

}