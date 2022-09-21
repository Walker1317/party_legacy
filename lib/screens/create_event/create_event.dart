import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';
import 'package:party/model/event.dart';
import 'package:party/model/usuario.dart';
import 'package:party/screens/create_event/create_event_script.dart';
import 'package:party/screens/widgets/loading_screen.dart';
import 'package:party/screens/widgets/party_icon.dart';
import 'package:http/http.dart' as http;

class CreateEvent extends StatefulWidget {
  CreateEvent(this.usuario);
  Usuario usuario;

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _formKey = GlobalKey<FormState>();
  Event event;
  File image;
  DateTime date;
  TimeOfDay time;

  bool isLoadingZIP = false;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerZip = TextEditingController();
  final TextEditingController _controllerStreet = TextEditingController();
  final TextEditingController _controllerDistrict = TextEditingController();
  final TextEditingController _controllerNumber = TextEditingController();
  final TextEditingController _controllerCity = TextEditingController();
  final TextEditingController _controllerState = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();
  final TextEditingController _controllerHour = TextEditingController();

  void _recoverCEP(String cep) async{

    setState(() {
      isLoadingZIP = true;
    });

    try{

      var url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
      http.Response response = await http.get(url);

      if(json.decode(response.body)['localidade'] != null){
        
        _controllerStreet.text = json.decode(response.body)['logradouro'];
        _controllerCity.text = json.decode(response.body)['localidade'];
        _controllerDistrict.text = json.decode(response.body)['bairro'];
        _controllerState.text = json.decode(response.body)['uf'];

      }
        setState(() {
          isLoadingZIP = false;
        });

      } catch (e){

        print('Carai teve um erro aí: $e');

      }
  }

  _selecionarImagemGaleria() async {

    XFile imagemSelecionada = await ImagePicker().pickImage(source: ImageSource.gallery);

    if( imagemSelecionada != null ){

      File croppedFile = await ImageCropper.cropImage(
        sourcePath: imagemSelecionada.path,
        aspectRatio: const CropAspectRatio(ratioX: 10, ratioY: 10),
        compressQuality: 60,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'adjust_image'.i18n(),
        ),
      );

      if(croppedFile != null){
        setState(() {
          image = croppedFile;
        });
      }
    }
  }

  _selectDate() async{

    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2023),
      locale: Locale('locale_language'.i18n(), 'locale_country'.i18n()),
    );

    if(data != null){

      date = data;

      _controllerDate.text = DateFormat(DateFormat.YEAR_MONTH_DAY, 'locale'.i18n())
      .format(date).toString();

    }
  }

  _selectTime() async{

    final timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );

    if(timeOfDay != null){

      time = timeOfDay;

      _controllerHour.text = time.format(context);

    }
  }

  @override
  void initState() {
    super.initState();
    event = Event.gerarId();
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
        title: Text('create_event'.i18n()),
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FormField<File>(
                    initialValue: image,
                    validator: (_){
                      if(_ == null){
                        return "select_image".i18n();
                      } 
                      return null;
                    },
                    builder: (state) {
                      
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: (){
                              if(image != null){
                    
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context){
                    
                                    return TextButton(
                                      onPressed: (){
                                        image = null;
                                        Navigator.of(context).pop();
                                        setState(() {
                                          image;
                                        });
                                      },
                                      child: Text('remove'.i18n())
                                    );
                                  }
                                );
                              } else {
                                _selecionarImagemGaleria();
                              }
                            
                            },
                            child: Container(
                              height: 300,
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.deepPurpleAccent[700], width: 2),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.deepPurpleAccent[700].withOpacity(0.3),
                                image: image != null ? DecorationImage(image: FileImage(image), fit: BoxFit.cover, opacity: 0.5) : null,
                              ),
                              child: image != null ? Icon(Ionicons.trash_bin_outline, size: 80, color: Colors.red,) : Icon(Icons.add_a_photo_outlined, size: 80, color: Colors.deepPurpleAccent[700],),
                            ),
                          ),
                          if( state.hasError )
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "[${state.errorText}]",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.red, fontSize: 14
                              ),
                            ),
                          ),
                        ],
                      );

                    }
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
                        //FilteringTextInputFormatter.allow(RegExp("[a-z A-Z 0-9']")),
                        LengthLimitingTextInputFormatter(50),
                      ],
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
                        PartyIcon(Ionicons.calendar_clear_outline),
                        const SizedBox(width: 10,),
                        Text('date_event'.i18n(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[800]),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: _controllerDate,
                      readOnly: true,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'tap_to_select_date'.i18n(),
                        suffixIcon: IconButton(
                          onPressed: _selectDate,
                          icon: Icon(Ionicons.calendar_clear_outline)
                        ),
                      ),
                      validator: (text){
                        if(text.length < 10){
                          return 'select_date'.i18n();
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
                        PartyIcon(Ionicons.time_outline),
                        const SizedBox(width: 10,),
                        Text('time_event'.i18n(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[800]),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: _controllerHour,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'tap_to_select_time'.i18n(),
                        suffixIcon: IconButton(
                          onPressed: _selectTime,
                          icon: Icon(Ionicons.time_outline)
                        ),
                      ),
                      validator: (text){
                        if(text.isEmpty){
                          return 'select_time'.i18n();
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
                        Text('postal'.i18n(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[800]),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: _controllerZip,
                        keyboardType: TextInputType.number,
                        onChanged: (text){

                          if(widget.usuario.country == 'BR'){

                            if(text.length == 8){
                              _recoverCEP(text);
                            } else {
                              _controllerStreet.text = '';
                              _controllerDistrict.text = '';
                              _controllerCity.text = '';
                              _controllerState.text = '';
                            }

                          }

                          

                        },
                        validator: (text){

                          if(text.isEmpty){
                            return 'zipCode_isEmpty'.i18n();
                          } else if(_controllerCity.text == ''){
                            return 'invalid_postalCode'.i18n();
                          } else {
                            return null;
                          }

                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(8)
                        ],
                    ),
                  ),

                  isLoadingZIP != true ? Container():
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: LinearProgressIndicator(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        PartyIcon(Ionicons.location_outline),
                        const SizedBox(width: 10,),
                        Text('street'.i18n(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[800]),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      enabled: false,
                      controller: _controllerStreet,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        PartyIcon(Ionicons.location_outline),
                        const SizedBox(width: 10,),
                        Text('number'.i18n(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[800]),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: _controllerNumber,
                      keyboardType: TextInputType.number,
                      validator: (text){
                        if(text.isEmpty){
                          return 'enter_the_number'.i18n();
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        PartyIcon(Ionicons.location_outline),
                        const SizedBox(width: 10,),
                        Text('district'.i18n(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[800]),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      enabled: false,
                      controller: _controllerDistrict,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        PartyIcon(Ionicons.location_outline),
                        const SizedBox(width: 10,),
                        Text('city'.i18n(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[800]),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      enabled: false,
                      controller: _controllerCity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        PartyIcon(Ionicons.location_outline),
                        const SizedBox(width: 10,),
                        Text('state'.i18n(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[800]),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      enabled: false,
                      controller: _controllerState,
                    ),
                  ),
                  const SizedBox(height: 80,),
                ],
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
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [
                      Colors.redAccent[400],
                      Colors.deepPurpleAccent[700]
                    ],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: (){

                    if(_formKey.currentState.validate()){
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context){
                          return const LoadingScreen();
                        }
                      );

                      event.title = _controllerName.text;
                      event.description = _controllerDescription.text;
                      event.date = date.toString();
                      event.time = _controllerHour.text;
                      event.zipCode = _controllerZip.text;
                      event.street = _controllerStreet.text;
                      event.number = _controllerNumber.text;
                      event.district = _controllerDistrict.text;
                      event.city = _controllerCity.text;
                      event.state = _controllerState.text;
                      event.country = widget.usuario.country;
                      event.premium = false;
                      event.premiumDate = DateTime.now().toString();
                      event.idCreator = widget.usuario.id;
                      event.createdAt = DateTime.now().toString(); 

                      CreatePartyEvent().create(widget.usuario, event, context, image);

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
                    "create_event".i18n(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}