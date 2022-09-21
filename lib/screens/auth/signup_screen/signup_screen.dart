import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/src/localization_extension.dart';
import 'package:http/http.dart' as http;
import 'package:party/model/usuario.dart';
import 'package:party/screens/widgets/loading_screen.dart';
import 'package:party/scripts/auth_services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({ Key key }) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String countryImage;
  String ct = 'country'.i18n();
  String regiaoSetada;
  bool obscureText = true;
  bool isLoadingZIP = false;
  bool showLocale = false;

  String district;
  String city;
  String state;

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();
  final TextEditingController _controllerZip = TextEditingController();

  setarRegiao(String uf){

    switch (uf) {
      case 'BR':
        countryImage = 'images/brasil.jpg';
        regiaoSetada = 'BR';
        break;
      case 'US':
        countryImage = 'images/usa.png';
        regiaoSetada = 'US';
        break;
      case 'ES':
        countryImage = 'images/spain.png';
        regiaoSetada = 'ES';
        break;
      default:
    }

    setState(() {
      countryImage;
    });

  }

  _escolherRegiao(){

    showDialog(
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          children: [
            ListTile(
              onTap: (){
                setarRegiao('BR');
                Navigator.of(context).pop();
              },
              leading: Container(
                height: 25,
                width: 45,
                child: Image.asset('images/brasil.jpg')),
              title: Text('Brasil'),
            ),
            ListTile(
              onTap: (){
                setarRegiao('ES');
                Navigator.of(context).pop();
              },
              leading: Container(
                height: 25,
                width: 45,
                child: Image.asset('images/spain.png')),
              title: Text('España'),
            ),
            ListTile(
              onTap: (){
                setarRegiao('US');
                Navigator.of(context).pop();
              },
              leading: Container(
                height: 25,
                width: 45, 
                child: Image.asset('images/usa.png')),
              title: Text('United States'),
            ),
          ],
        );
      }
    );

  }


  void _recoverCEP(String cep) async{

    setState(() {
      isLoadingZIP = true;
    });

    try{

      var url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
      http.Response response = await http.get(url);

      if(json.decode(response.body)['localidade'] != null){

        city = json.decode(response.body)['localidade'];
        district = json.decode(response.body)['bairro'];
        state = json.decode(response.body)['uf'];

        setState(() {
          showLocale = true;
        });

      }
      
      

      setState(() {
        isLoadingZIP = false;
      });

    } catch (e){

      print('Carai teve um erro aí: $e');

    }

  }


  @override
  void initState() {
    super.initState();
    setarRegiao(ct);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/partyBackground.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: ()=> Navigator.of(context).pop(),
            icon: const Icon(Iconsax.close_square, size: 30, color: Colors.white,)
          ),
          actions: [
            TextButton(
              onPressed: _escolherRegiao,
              child: SizedBox(
                height: 25,
                width: 45,
                child: countryImage != null ? Image.asset(countryImage) : null
              ),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    color: Colors.white,
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 3, bottom: 4, top: 8),
                            child: Text(
                              'name'.i18n(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          TextFormField(
                            controller: _controllerName,
                            validator: (text){

                              if(text.isEmpty){
                                return 'name_isEmpty'.i18n();
                                
                              } else if(text.length < 8){
                                return 'invalid_name'.i18n();
                              } else {
                                return null;
                              }

                            },
                            textCapitalization: TextCapitalization.words,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
                              LengthLimitingTextInputFormatter(20),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3, bottom: 4, top: 8),
                            child: Text(
                              'postal'.i18n(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _controllerZip,
                            keyboardType: TextInputType.number,
                            onChanged: (text){

                              if(regiaoSetada == 'BR'){

                                if(text.length == 8){
                                  _recoverCEP(text);
                                } else {
                                  setState(() {
                                    showLocale = false;
                                  });
                                }

                              }
        
                              
        
                            },
                            validator: (text){

                              if(text.isEmpty){
                                return 'zipCode_isEmpty'.i18n();
                              } else if(showLocale != true){
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
        
        
                          isLoadingZIP != false ? LinearProgressIndicator(
                            color: Colors.redAccent[400],
                          ) : Container(),
        
                          showLocale != false ? 
        
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent[700],
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text('${city} / ${state}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center,),
                          ) : Container(),
        
                          Padding(
                            padding: const EdgeInsets.only(left: 3, bottom: 4, top: 8),
                            child: Text(
                              'email'.i18n(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _controllerEmail,
                            keyboardType: TextInputType.emailAddress,
                            validator: (text){
                              if(text.isEmpty){
                                return 'email_isEmpty'.i18n();
                              } else if(!text.contains('@')){
                                return 'invalid_email'.i18n();
                              } else if(!text.contains('.')){
                                return 'invalid_email'.i18n();
                              } else {
                                return null;
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 3, bottom: 4, top: 8),
                            child: Text(
                              'password'.i18n(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[900],
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _controllerSenha,
                            obscureText: obscureText,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: (){
                                  if(obscureText == true){
                                    obscureText = false;
                                  } else if (obscureText == false){
                                    obscureText = true;
                                  }
                                  setState(() {
                                    obscureText;
                                  });
                                },
                                icon: Icon(obscureText != true ? Ionicons.eye_off_outline : Ionicons.eye_outline)
                              ),
                            ),
                            validator: (text){
                              if(text.length < 6){
                                return 'password_less6'.i18n();
                              } else {
                                return null;
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(50),
                            ],
                          ),
                          Container(
                            height: 50,
                            margin: const EdgeInsets.only(top: 20,),
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
                                    builder: (BuildContext context){
                                      return LoadingScreen();
                                    }
                                  );

                                  Usuario usuario = Usuario();
                                  usuario.name = _controllerName.text;
                                  usuario.email = _controllerEmail.text;
                                  usuario.pass = _controllerSenha.text;
                                  usuario.urlImage = null;
                                  usuario.district = district;
                                  usuario.city = city;
                                  usuario.zipCode = _controllerZip.text;
                                  usuario.state = state;
                                  usuario.country = regiaoSetada;
                                  usuario.userType = 'Standard';
                                  usuario.verified = true;

                                  AuthServices().signUpWithEmail(usuario, context);

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
                                "register".i18n(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}