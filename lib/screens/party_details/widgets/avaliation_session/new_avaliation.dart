import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';
import 'package:party/model/avaliation.dart';
import 'package:party/model/party.dart';
import 'package:party/model/usuario.dart';

class NewAvaliation extends StatefulWidget {
  NewAvaliation(this.party, {this.enabled = true});
  Party party;
  bool enabled;

  @override
  _NewAvaliationState createState() => _NewAvaliationState();
}

class _NewAvaliationState extends State<NewAvaliation> {

  Color color1;
  Color color2;
  Color color3;
  Color color4;
  Color color5;

  int finalValue;
  bool send;
  bool isLoading = false;
  bool enabled = true;

  final TextEditingController _controllerMessage = TextEditingController();

  _setOneStar(){

    setState(() {
      color1 = Colors.amber[600];
      color2 = Colors.black38;
      color3 = Colors.black38;
      color4 = Colors.black38;
      color5 = Colors.black38;
      finalValue = 1;
      send = true;
    });

  }

  _setTwoStar(){

    setState(() {
      color1 = Colors.amber[600];
      color2 = Colors.amber[600];
      color3 = Colors.black38;
      color4 = Colors.black38;
      color5 = Colors.black38;
      finalValue = 2;
      send = true;
    });

  }

  _setThreeStar(){

    setState(() {
      color1 = Colors.amber[600];
      color2 = Colors.amber[600];
      color3 = Colors.amber[600];
      color4 = Colors.black38;
      color5 = Colors.black38;
      finalValue = 3;
      send = true;
    });

  }

  _setFourStar(){

    setState(() {
      color1 = Colors.amber[600];
      color2 = Colors.amber[600];
      color3 = Colors.amber[600];
      color4 = Colors.amber[600];
      color5 = Colors.black38;
      finalValue = 4;
      send = true;
    });

  }

  _setFiveStar(){

    setState(() {
      color1 = Colors.amber[600];
      color2 = Colors.amber[600];
      color3 = Colors.amber[600];
      color4 = Colors.amber[600];
      color5 = Colors.amber[600];
      finalValue = 5;
      send = true;
    });

  }

  _sendAvaliation() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser;
    FirebaseFirestore _db = FirebaseFirestore.instance;

    if(isLoading == false){
      setState(() {
        isLoading = true;
        enabled = false;
      });


      DocumentSnapshot snapshot = await _db.collection('users').doc(user.uid).get();
      Usuario usuario = Usuario.fromDocumentSnapshot(snapshot);

      Avaliation avaliation = Avaliation();
      avaliation.userId = user.uid;
      avaliation.avaliation = finalValue;
      avaliation.image = usuario.urlImage;
      avaliation.message = _controllerMessage.text;
      avaliation.date = DateTime.now().toString();
      avaliation.name = usuario.name;

      DocumentSnapshot snapshotParty = await _db.collection('parties').doc(widget.party.id).get();
      Map<String, dynamic> datas = snapshotParty.data();

      num newAvaliation = datas["Avaliations"] + 1;
      num newTotalStars = datas["TotalStars"] + finalValue;

      _db
      .collection('parties')
      .doc(widget.party.id)
      .update({

        "Avaliations" : newAvaliation,
        "TotalStars" : newTotalStars,
        "Stars" : newTotalStars / newAvaliation,


      });

      _db
      .collection('parties')
      .doc(widget.party.id)
      .collection('avaliations')
      .doc(usuario.id)
      .set(avaliation.toMap()).then((_){

        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.greenAccent[400],
            duration: Duration(seconds: 3),
            content: Text('evaluation_sent'.i18n()),
          ),
        );

        setState(() {
          widget.enabled = false;
        });

      }).catchError((e){

        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            content: Text('evaluation_sent'.i18n()),
          ),
        );

        setState(() {
          isLoading = false;
          enabled = true;
        });


      });
      

    }

  }

  @override
  void initState() {
    super.initState();
      color1 = Colors.black38;
      color2 = Colors.black38;
      color3 = Colors.black38;
      color4 = Colors.black38;
      color5 = Colors.black38;
      finalValue = 0;
      send = false;
  }


  @override
  Widget build(BuildContext context) {
    return widget.enabled == false ? Container() : Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AvaliationButton(
                color: color1,
                onPressed: _setOneStar
              ),
              const SizedBox(width: 10,),
              AvaliationButton(
                color: color2,
                onPressed: _setTwoStar
              ),
              const SizedBox(width: 10,),
              AvaliationButton(
                color: color3,
                onPressed: _setThreeStar
              ),
              const SizedBox(width: 10,),
              AvaliationButton(
                color: color4,
                onPressed: _setFourStar
              ),
              const SizedBox(width: 10,),
              AvaliationButton(
                color: color5,
                onPressed: _setFiveStar
              ),
              const SizedBox(width: 10,),
              Text('  $finalValue', style: TextStyle(color: Colors.grey[800], fontSize: 30, fontWeight: FontWeight.bold),)
            ],
          ),
          send == false ? Container() :
          
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text('leave_message'.i18n(), style: TextStyle(color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextField(
                  enabled: enabled,
                  maxLines: 5,
                  controller: _controllerMessage,
                  textCapitalization: TextCapitalization.sentences,
                  maxLength: 200,
                ),
              ),
              Container(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  onPressed: _sendAvaliation,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)
                    )
                  ),
                  child: isLoading == true ? const CircularProgressIndicator(color: Colors.white,) : Text('send'.i18n(), style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}

class AvaliationButton extends StatelessWidget {
  AvaliationButton({@required this.onPressed, this.color});
  VoidCallback onPressed;
  Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(Ionicons.star, color: color, size: 40,)
    );
  }
}