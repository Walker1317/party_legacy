import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';
import 'package:party/model/party.dart';
import 'package:party/screens/party_details/widgets/avaliation_session/avaliation_session.dart';
import 'package:party/screens/party_details/widgets/contact_session.dart';
import 'package:party/screens/party_details/widgets/gallery_images/gallery_images.dart';
import 'package:party/screens/party_details/widgets/party_sliver_appbar.dart';
import 'package:party/screens/party_details/widgets/star_session.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

/*class PartyDetails extends StatefulWidget {
  PartyDetails(this.party);
  Party party;

  @override
  _PartyDetailsState createState() => _PartyDetailsState();
}

class _PartyDetailsState extends State<PartyDetails> {
  
}*/

class PartyDetails extends StatefulWidget{
  PartyDetails(this.party);
  Party party;

  @override
  State<PartyDetails> createState() => _PartyDetailsState();
}

class _PartyDetailsState extends State<PartyDetails> with AutomaticKeepAliveClientMixin<PartyDetails>{
  
  Set<Marker> _markers = {};

  _showMarker() async {

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'images/mark.png'
    ).then((BitmapDescriptor icon){

      Marker partyMarker = Marker(
        markerId: const MarkerId("party-marker"),
        position: LatLng(widget.party.latitude, widget.party.longitude),
        infoWindow: InfoWindow(
          title: widget.party.title
        ),
        icon: icon
      );

      setState(() {
        _markers.add(partyMarker);
      });

    });
  }

  @override
  void initState() {
    super.initState();
    _showMarker();
  }
  
  @override
  Widget build(BuildContext context) => Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          PartySliverAppBar(widget.party),
          body(widget.party),
        ],
      ),
    );

  Widget body(Party party) => SliverToBoxAdapter(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StarSession(party),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text('description'.i18n(), style: const TextStyle(color: Colors.grey),),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(party.description, textAlign: TextAlign.justify,),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text('photos'.i18n(), style: const TextStyle(color: Colors.grey),),
        ),
        GalleryImages(party),
        const Divider(),
        ContactSession(party),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text('avaliations_upper'.i18n(), style: const TextStyle(color: Colors.grey),),
        ),
        AvaliationSession(party),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Text('localization'.i18n(), style: const TextStyle(color: Colors.grey),),
        ),
        SizedBox(
          height: 300,
          child: GoogleMap(
            markers: _markers,
            tiltGesturesEnabled: false,
            zoomGesturesEnabled: false,
            rotateGesturesEnabled: false,
            scrollGesturesEnabled: false,
            initialCameraPosition: CameraPosition(target: LatLng(widget.party.latitude, widget.party.longitude), zoom: 15)
          ),
        ),
        TextButton(
          onPressed: () async{
            
            String address = '${party.street}, ${party.number} - ${party.district},${party.zipCode}'.replaceAll(RegExp(' '), '+');
            String url = 'https://www.google.com/maps/place/$address/@${widget.party.latitude},${widget.party.longitude},16z';
            print(url);
            if(!await launch(url,)) throw 'Não foi possivel abrir mapa';

          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Iconsax.map,),
              const SizedBox(width: 10,),
              Text('open_location'.i18n())
            ],
          )
        ),
        const SizedBox(height: 200,),
      ],
    ),
  );

  @override
  bool get wantKeepAlive => true;
}
