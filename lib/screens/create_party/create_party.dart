import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';
import 'package:party/model/party.dart';
import 'package:party/model/usuario.dart';
import 'package:party/screens/widgets/loading_screen.dart';
import 'dart:io';
import 'package:party/screens/widgets/party_icon.dart';
import 'package:party/scripts/dropdown_menu_options.dart';

class CreateParty extends StatefulWidget {
  CreateParty(this.usuario);
  Usuario usuario;

  @override
  _CreatePartyState createState() => _CreatePartyState();
}

class _CreatePartyState extends State<CreateParty>{
  List<File> _listaImagens = [];
  final _formKey = GlobalKey<FormState>();
  Party party;
  bool isLoadingZIP = false;
  String _categorySelected;
  bool categorySelected;

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();


  _selecionarImagemGaleria() async {

    XFile imagemSelecionada = await ImagePicker().pickImage(source: ImageSource.gallery);

    if( imagemSelecionada != null ){

      File croppedFile = await ImageCropper.cropImage(
        sourcePath: imagemSelecionada.path,
        aspectRatio: _listaImagens.length < 1 ? const CropAspectRatio(ratioX: 16, ratioY: 9) : const CropAspectRatio(ratioX: 18, ratioY: 20),
        maxHeight: 1280,
        maxWidth: 720,
        compressQuality: 60,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'adjust_image'.i18n(),
        ),
      );

      if(croppedFile != null){
        setState(() {
          _listaImagens.add( croppedFile );
        });
      }
    }
  }


  _saveParty() async{
    await _uploadImagens();

    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection('parties')
      .doc(party.id)
      .set(party.toMap()).then((_){

        db.collection("users")
          .doc(widget.usuario.id)
          .update({

            'PartyID' : party.id,

        }).then((_){

          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);

        }).catchError((e){

          print('erro ao salvar party no usuario: $e');

        });

      }).catchError((e){

        print('erro ao salvar party: $e');

      });

  }


  Future _uploadImagens() async {

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();

    for( var imagem in _listaImagens ){

      String nomeImagem = DateTime.now().millisecondsSinceEpoch.toString();
      Reference arquivo = pastaRaiz
          .child("party")
          .child( party.id )
          .child( nomeImagem );

      UploadTask uploadTask = arquivo.putFile(imagem);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      String url = await taskSnapshot.ref.getDownloadURL();
      party.images.add(url);

    }

  }


  Set<Marker> _markers = {};

  _showMarker(Location location) async {

    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      'images/mark.png'
    ).then((BitmapDescriptor icon){

      Marker partyMarker = Marker(
        markerId: const MarkerId("party-marker"),
        position: LatLng(location.latitude, location.longitude),
        infoWindow: InfoWindow(
          title: _controllerName.text
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
    party = Party.gerarId();
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
        title: Text('create_establishment'.i18n()),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 10,),
                  FormField<List>(
                    initialValue: _listaImagens,
                    validator: ( imagens ){
                      if( imagens.length == 0 ){
                        return "select_image".i18n();
                      }
                      return null;
                    },
                    builder: (state){
                      return Column(children: <Widget>[
                        SizedBox(
                          height: 240,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: _listaImagens.length + 1, //3
                              itemBuilder: (context, indice){
                                if( indice == _listaImagens.length ){
                                  return _listaImagens.length >= 10 ? Container() : Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                      onTap: (){
                                        _selecionarImagemGaleria();
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        width: 390,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.deepPurpleAccent[700],
                                            width: 2
                                          ),
                                          color: Colors.deepPurpleAccent[700].withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Icon(
                                          Icons.add_a_photo_outlined,
                                          color: Colors.deepPurpleAccent[700],
                                          size: 90,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                if( _listaImagens.isNotEmpty){
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: GestureDetector(
                                      onTap: (){
                                        showDialog(
                                            context: context,
                                            builder: (context) => Dialog(
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                    Image.file( _listaImagens[indice] ),
                                                    TextButton(
                                                      child: const Text("Excluir", style: TextStyle(color: Colors.red),),
                                                      onPressed: (){
                                                        setState((){
                                                          _listaImagens.removeAt(indice);
                                                          Navigator.of(context).pop();
                                                          }
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Positioned(
                                                  top: 2,
                                                  right: 2,
                                                  child: IconButton(
                                                    onPressed: ()=> Navigator.of(context).pop(),
                                                    icon: const Icon(Icons.close, color: Colors.white,),
                                                  ),
                                                ),
                                              ],
                                              ),
                                          )
                                        );
                                      },
                                      child: Container(
                                        width: 300,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(image: FileImage( _listaImagens[indice] ), fit: BoxFit.cover)
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.deepPurpleAccent[700].withOpacity(0.6),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: const Icon(
                                            Icons.delete_forever_rounded,
                                            color: Colors.red,
                                            size: 60,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Container();

                              }
                          ),
                        ),
                        if( state.hasError )
                          Text(
                            "[${state.errorText}]",
                            style: const TextStyle(
                              color: Colors.red, fontSize: 14
                            ),
                          )
                      ],);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        PartyIcon(Ionicons.storefront_outline),
                        const SizedBox(width: 10,),
                        Text('name'.i18n(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[800]),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: _controllerName,
                      textCapitalization: TextCapitalization.words,
                      validator: (text){
                        if(text.isEmpty){
                          return 'name_isEmpty'.i18n();
                        } else if (text.length < 6){
                          return 'invalid_name'.i18n();
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[a-z A-Z 0-9']")),
                        LengthLimitingTextInputFormatter(50),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        PartyIcon(Ionicons.bookmark_outline),
                        const SizedBox(width: 10,),
                        Text('category'.i18n(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[800]),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButtonFormField(
                      value: _categorySelected,
                      items: categoryList,
                      onChanged: (valor){
                        setState(() {
                          categorySelected = false;
                          _categorySelected = valor;
                          categorySelected = true;
                        });
                        print(_categorySelected);
                      },
                      validator: (valor){
                        if (valor == null) {
                          return 'select_a_category'.i18n();
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        PartyIcon(Ionicons.reader_outline),
                        const SizedBox(width: 10,),
                        Text('description'.i18n(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[800]),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: _controllerDescription,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 10,
                      maxLength: 500,
                      validator: (text){
                        if(text.length < 10){
                          return 'type_description'.i18n();
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        PartyIcon(Ionicons.location_outline),
                        const SizedBox(width: 10,),
                        Text('address'.i18n(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[800]),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: _controllerAddress,
                      textCapitalization: TextCapitalization.words,
                      validator: (text){
                        if(text.isEmpty){
                          return 'enter_the_address'.i18n();
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: (){

                            showDialog(
                              context: context,
                              builder: (BuildContext context){

                                return AlertDialog(
                                  title: const Text('Google Maps'),
                                  content: Text('maps_info'.i18n(), textAlign: TextAlign.justify,),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: ()=> Navigator.of(context).pop(),
                                      child: const Text('OK')
                                    ),
                                  ],
                                );

                              }
                            );
                          },
                          icon: const Icon(Icons.info_outline_rounded)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80,),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 20,
              //margin: const EdgeInsets.symmetric(horizontal: 20,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  colors: [
                    Color.fromRGBO(255, 23, 68, 1),
                    Color.fromRGBO(98, 0, 234, 1)
                  ],
                ),
              ),
              child: ElevatedButton(
                onPressed: () async{

                  if(_formKey.currentState.validate()) {
                    _markers.clear();

                    try{

                      List<Location> locations = await locationFromAddress(_controllerAddress.text);
                      Location location = locations[0];
                      
                      List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
                      Placemark placemark = placemarks[0];

                      print(placemark);

                      print(location.latitude);
                      print(location.longitude);

                      _showMarker(location);

                      showDialog(
                        context: context,
                        builder: (BuildContext context){

                          return SimpleDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'confirm_address'.i18n(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  '${placemark.street}, ${placemark.name} - ${placemark.subLocality}, ${placemark.postalCode} - ${placemark.subAdministrativeArea}/${placemark.administrativeArea}',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(color: Color.fromRGBO(158, 158, 158, 1)),
                                ),
                              ),
                              SizedBox(
                                height: 300,
                                width: 300,
                                child: GoogleMap(
                                  markers: _markers,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(location.latitude, location.longitude),
                                    zoom: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: ElevatedButton(
                                        onPressed: ()=> Navigator.of(context).pop(),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.grey[300],
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100)
                                          )
                                        ),
                                        child: const Icon(Icons.close, color: Color(0xFF424242),),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    SizedBox(
                                      height: 60,
                                      width: 60,
                                      child: ElevatedButton(
                                        onPressed: (){

                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context){
                                              return const LoadingScreen();
                                            }
                                          );

                                          party.title = _controllerName.text;
                                          party.idCreator = widget.usuario.id;
                                          party.description = _controllerDescription.text;
                                          party.zipCode = placemark.postalCode;
                                          party.street = placemark.street;
                                          party.number = placemark.name;
                                          party.district = placemark.subLocality;
                                          party.city = placemark.subAdministrativeArea;
                                          party.state = placemark.administrativeArea;
                                          party.country = placemark.country;
                                          party.avaliations = 0;
                                          party.stars = 0;
                                          party.category = _categorySelected;
                                          party.totalStars = 0;
                                          party.latitude = location.latitude;
                                          party.longitude = location.longitude;
                                          party.createdAt = DateTime.now().toString();
                                          party.dateFilter = DateTime.now().toString();
                                          party.type = 'standard';
                                          _saveParty();

                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.greenAccent[700],
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100)
                                          )
                                        ),
                                        child: const Icon(Icons.check),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        }
                      );

                    }catch(e){

                      showDialog(
                        context: context,
                        builder: (BuildContext context){

                          return AlertDialog(
                            title: const Text('Oops!'),
                            content: Text('address_error'.i18n()),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            actions: [
                              TextButton(
                                onPressed: ()=> Navigator.of(context).pop(),
                                child: const Text('OK')
                              ),
                            ],
                          );

                        }
                      );

                    }

                  }

                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)
                  ),
                  primary: Colors.transparent,
                  shadowColor: Colors.transparent
                ),
                child: Text(
                  "create_party".i18n(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}