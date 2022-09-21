import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:party/model/avaliation.dart';
import 'package:party/model/party.dart';


class UserStarsAvaliation extends StatelessWidget {
  UserStarsAvaliation(this.avaliation, {this.lightTheme = false});

  Avaliation avaliation;
  bool lightTheme;
  Color lightColor = Colors.black54;
  Color darkColor = Colors.black12;
  Color color;

  var currentStars;

  var zeroStars = Row(
    children: const [
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
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
        child: Icon(Ionicons.star, color: Colors.black12,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
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
        child: Icon(Ionicons.star, color: Colors.black12,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
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
        child: Icon(Ionicons.star, color: Colors.black12,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
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
        child: Icon(Ionicons.star, color: Colors.black12,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
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
        child: Icon(Ionicons.star, color: Colors.black12,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
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
        child: Icon(Ionicons.star, color: Colors.black12,),
      ),
      Padding(
        padding: EdgeInsets.only(right: 3.0),
        child: Icon(Ionicons.star, color: Colors.black12,),
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
        child: Icon(Ionicons.star, color: Colors.black12,),
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
        child: Icon(Ionicons.star, color: Colors.black12,),
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

    if(avaliation.avaliation < 0.5){
      currentStars = zeroStars;
    } else if(avaliation.avaliation < 1){
      currentStars = zeroMidStars;
    } else if(avaliation.avaliation < 1.5){
      currentStars = oneStars;
    } else if(avaliation.avaliation < 2){
      currentStars = oneMidStars;
    } else if(avaliation.avaliation < 2.5){
      currentStars = twoStars;
    } else if(avaliation.avaliation < 3){
      currentStars = twoStars;
    } else if(avaliation.avaliation < 3.5){
      currentStars = threeStars;
    } else if(avaliation.avaliation < 4){
      currentStars = threeMidStars;
    } else if(avaliation.avaliation < 4.5){
      currentStars = fourStars;
    } else if(avaliation.avaliation < 5){
      currentStars = fourMidStars;
    } else if(avaliation.avaliation >= 5){
      currentStars = fiveStars;
    }

  }

  @override
  Widget build(BuildContext context) {

    _setStars();

    return currentStars != null ? Row(
      children: [
        currentStars,
        
      ],
    ) : Container();
  }
}