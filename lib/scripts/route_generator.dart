import 'package:flutter/material.dart';
import 'package:party/party_adm/my_parties.dart';
import 'package:party/screens/auth/signin_screen/signin_screen.dart';
import 'package:party/screens/auth/signup_screen/signup_screen.dart';
import 'package:party/screens/base_screen/base_screen.dart';
import 'package:party/screens/create_event/create_event.dart';
import 'package:party/screens/create_party/create_party.dart';
import 'package:party/screens/event_details/event_details.dart';
import 'package:party/screens/party_details/party_details.dart';
import 'package:party/screens/party_shop/party_coins/party_coins.dart';
import 'package:party/screens/party_shop/party_shop.dart';
import 'package:party/screens/perfil_screen/perfil_screen.dart';
import 'package:party/screens/splash_screen/change_local_permission.dart';
import 'package:party/screens/splash_screen/splash_screen.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch(settings.name){
      case '/' :
      return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/localPermission' :
      return MaterialPageRoute(builder: (_) => const ChangeLocalPermission());
      /*case '/baseScreen' :
      return MaterialPageRoute(builder: (_) => BaseScreen(args));*/
      case '/signin' :
      return MaterialPageRoute(builder: (_) => const SigninScreen());
      case '/signup' :
      return MaterialPageRoute(builder: (_) => const SignupScreen());
      case '/perfilScreen' :
      return MaterialPageRoute(builder: (_) => PerfilScreen(args));
      case '/createParty' :
      return MaterialPageRoute(builder: (_) => CreateParty(args));
      case '/createEvent' :
      return MaterialPageRoute(builder: (_) => CreateEvent(args));
      case '/partyDetails' :
      return MaterialPageRoute(builder: (_) => PartyDetails(args));
      case '/eventDetails' :
      return MaterialPageRoute(builder: (_) => EventDetails(args));
      case '/myParties' :
      return MaterialPageRoute(builder: (_) => MyParties(args));
      case '/partyShop' :
      return MaterialPageRoute(builder: (_) => const PartyShop());
      case '/partyCoins' :
      return MaterialPageRoute(builder: (_) => const PartyCoins());
      
      default:
        _erroRota();
    }

  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        body: Center(
          child: Text('Tela não encontrada'),
        ),
      );
    });
  }

}