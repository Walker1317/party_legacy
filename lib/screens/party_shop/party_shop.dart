import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:party/screens/party_shop/widgets/my_coins_button.dart';
import 'package:party/screens/widgets/party_icon.dart';

class PartyShop extends StatelessWidget {
  const PartyShop({ Key key }) : super(key: key);

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
        title: const Text('Party Shop'),
        actions: const [
          MyCoinsButton(),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ShopProduct('Return to top', '10', Ionicons.bag_handle_outline),
              ShopProduct('Return to top', '150', Ionicons.bag_handle_outline),
              ShopProduct('Return to top', '20', Ionicons.bag_handle_outline),
              ShopProduct('Return to top', '25', Ionicons.bag_handle_outline),
              ShopProduct('Return to top', '20', Ionicons.bag_handle_outline),
              ShopProduct('Return to top', '45', Ionicons.bag_handle_outline),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopProduct extends StatelessWidget {
  ShopProduct(this.title, this.value, this.icon);
  String title;
  String value;
  IconData icon;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PartyIcon(icon, size: 30,),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromRGBO(51, 51, 51, 1))),
            const SizedBox(height: 20),
            Row(
              children: [
                Image.asset('images/party_coins.png', fit: BoxFit.scaleDown, scale: 20,),
                const SizedBox(width: 5),
                Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 245, 171, 0))),
              ],
            ),
          ],
        )
      ),
    );
  }
}