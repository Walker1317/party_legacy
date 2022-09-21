import 'package:flutter/material.dart';

class MyCoinsButton extends StatefulWidget {
  const MyCoinsButton({ Key key }) : super(key: key);

  @override
  State<MyCoinsButton> createState() => _MyCoinsButtonState();
}

class _MyCoinsButtonState extends State<MyCoinsButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: ()=> Navigator.pushNamed(context, '/partyCoins'),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.redAccent[400],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Row(
          children: [
            Image.asset('images/party_coins.png', fit: BoxFit.scaleDown, scale: 18,),
            const SizedBox(width: 5,),
            const Text('1343', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(66, 66, 66, 1)),)
          ],
        ),
      ),
    );
  }
}