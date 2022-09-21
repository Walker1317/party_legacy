import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/src/localization_extension.dart';
import 'package:party/model/usuario.dart';
import 'package:party/screens/splash_screen/splash_screen.dart';
import 'package:party/screens/widgets/loading_screen.dart';
import 'package:party/scripts/auth_services.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({ Key key }) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();
  

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
        ),
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16),
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
                          Text(
                            'email_access'.i18n(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey[900]),
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.only(left: 3, bottom: 4, top: 8),
                            child: Text(
                              'email'.i18n(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.w700),
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
                              LengthLimitingTextInputFormatter(50)
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 3, bottom: 4, top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'password'.i18n(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.w700),
                                ),
                                GestureDetector(
                                  child: Text(
                                    'pass_recover'.i18n(),
                                    style: TextStyle(
                                        color: Colors.deepPurpleAccent[700],
                                        decoration: TextDecoration.underline),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                          TextFormField(
                            controller: _controllerPass,
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
                                  usuario.email = _controllerEmail.text;
                                  usuario.pass = _controllerPass.text;

                                  AuthServices().logarUsuario(usuario, context);

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
                                "enter".i18n(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LoginMethod(Colors.blue, Ionicons.logo_facebook),
                              LoginMethod(Colors.red, Ionicons.logo_google),
                              LoginMethod(Colors.black, Ionicons.phone_portrait_outline),
                            ],
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              children: <Widget>[
                                Text(
                                  'no_account'.i18n(),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: Text(
                                    'register'.i18n(),
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.deepPurpleAccent[700],
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              ],
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

class LoginMethod extends StatelessWidget {
  LoginMethod(this.color, this.icon,{this.route});
  Color color;
  IconData icon;
  String route;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 102,
      width: 102,
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          primary: color,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          )
        ),
        child: Icon(icon, color: Colors.white, size: 40,),
      )
    );
  }
}