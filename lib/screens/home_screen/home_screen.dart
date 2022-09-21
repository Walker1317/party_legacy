import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:party/model/usuario.dart';
import 'package:party/screens/home_screen/widgets/ad_caroussel.dart';
import 'package:party/screens/home_screen/widgets/stream_event/stream_event.dart';
import 'package:party/screens/home_screen/widgets/stream_party/stream_party.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(this.usuario, this.pageController, this.placemark);
  Usuario usuario;
  PageController pageController;
  Placemark placemark;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
          children: [
            const ADCaroussel(),
            StreamParty(widget.pageController, widget.placemark),
            //SizedBox(height: 20,),
            StreamEventsHome(widget.pageController, widget.placemark)
          ],
        ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}