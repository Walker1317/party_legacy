import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';
import 'package:party/model/avaliation.dart';
import 'package:party/screens/party_details/widgets/avaliation_session/user_stars.dart';

class AvaliationBuild extends StatelessWidget {
  AvaliationBuild(this.avaliation, {this.myAvaliation = false});
  Avaliation avaliation;
  bool myAvaliation;
  String dateS;

  _recoverDate(){
    DateTime date = DateTime.parse(avaliation.date);
    var data = DateFormat(DateFormat.YEAR_MONTH_DAY, 'locale'.i18n()).format(date);

    dateS = data.toString();
  }

  @override
  Widget build(BuildContext context) {

    _recoverDate();

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        margin: myAvaliation == true ? const EdgeInsets.symmetric(horizontal: 10) : null,
        padding: myAvaliation == true ? const EdgeInsets.symmetric(vertical: 10) : null,
        decoration: BoxDecoration(
          color: myAvaliation == true ? Colors.yellow.withOpacity(0.2) : null,
          borderRadius: BorderRadius.circular(20),
          border: myAvaliation == true ? Border.all(
            color: const Color.fromARGB(255, 255, 213, 0),
            width: 2
          ): null
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: avaliation.image != null ? NetworkImage(avaliation.image) : null,
            child: avaliation.image != null ? null : Icon(Ionicons.person_outline),
          ),
          title: Wrap(
            children: [
              Text(avaliation.name, style: TextStyle(color: Colors.grey, fontSize: 12),),
              Text("    $dateS", style: TextStyle(color: Colors.grey, fontSize: 10),),
            ],
          ),
          subtitle: Column(

            children: [
              const SizedBox(height: 5,),
              avaliation.message != "" ? Text('${avaliation.message}'): Container(),
              const SizedBox(height: 5,),
              UserStarsAvaliation(avaliation),
            ],
          ),
        ),
      ),
    );
  }
}