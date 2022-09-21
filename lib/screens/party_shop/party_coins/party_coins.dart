import 'package:flutter/material.dart';

class PartyCoins extends StatelessWidget {
  const PartyCoins({ Key key }) : super(key: key);

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
        title: const Text('Party Coins'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              PartyCoinBuild('10', 'images/party_coins.png', '9,90'),
              PartyCoinBuild('50', 'images/party_coins_5.png', '45,90'),
              PartyCoinBuild('100', 'images/party_coins_5.png', '89,90'),
              PartyCoinBuild('250', 'images/party_coins_10.png', '229,90'),
              PartyCoinBuild('500', 'images/party_coins_20.png', '479,90'),
              PartyCoinBuild('1250', 'images/party_coins_20.png', '949,90'),
            ],
          ),
        ),
      ),
    );
  }
}

class PartyCoinBuild extends StatelessWidget {
  PartyCoinBuild(this.title, this.image, this.price);
  String title;
  String price;
  String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 123.8,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          primary: Colors.white,
          onPrimary: Colors.grey[300],
          elevation: 3
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, fit: BoxFit.scaleDown, scale: 6,),
            const SizedBox(height: 10),
            Text('+$title', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 210, 10))),
            Text('R\$ $price', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(66, 66, 66, 1))),
            const SizedBox(height: 10),
          ],
        )
      ),
    );
  }
}