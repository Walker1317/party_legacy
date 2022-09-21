import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:party/model/party.dart';

class LightAvaliationStars extends StatelessWidget {
  LightAvaliationStars(this.party);

  Party party;

  var currentStars;

  var zeroStars = Row(
    children: const [
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
    ],
  );

  var zeroMidStars = Row(
    children: const [
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star_half, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
    ],
  );

  var oneStars = Row(
    children: const [
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
    ],
  );

  var oneMidStars = Row(
    children: const [
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star_half_outline, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
    ],
  );

  var twoStars = Row(
    children: const [
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
    ],
  );

  var towMidStars = Row(
    children: const [
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star_half_outline, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
    ],
  );

  var threeStars = Row(
    children: const [
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
    ],
  );

  var threeMidStars = Row(
    children: const [
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star_half_outline, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
    ],
  );

  var fourStars = Row(
    children: const [
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black26,),
      ),
    ],
  );

  var fourMidStars = Row(
    children: const [
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star_half, color: Color.fromARGB(255, 255, 213, 0),),
      ),
    ],
  );

  var fiveStars = Row(
    children: const [
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Color.fromARGB(255, 255, 213, 0),),
      ),
    ],
  );

  _setStars(){

    if(party.stars < 0.5){
      currentStars = zeroStars;
    } else if(party.stars < 1){
      currentStars = zeroMidStars;
    } else if(party.stars < 1.5){
      currentStars = oneStars;
    } else if(party.stars < 2){
      currentStars = oneMidStars;
    } else if(party.stars < 2.5){
      currentStars = twoStars;
    } else if(party.stars < 3){
      currentStars = twoStars;
    } else if(party.stars < 3.5){
      currentStars = threeStars;
    } else if(party.stars < 4){
      currentStars = threeMidStars;
    } else if(party.stars < 4.5){
      currentStars = fourStars;
    } else if(party.stars < 5){
      currentStars = fourMidStars;
    } else if(party.stars >= 5){
      currentStars = fiveStars;
    }

  }

  @override
  Widget build(BuildContext context) {

    _setStars();

    return currentStars != null ? 
      Padding(
        padding: const EdgeInsets.only(left: 0, right: 10, bottom: 5),
        child: currentStars,
      )
      : Container();
  }
}