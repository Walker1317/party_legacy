import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('images/partyBackground.jpg'),
          fit: BoxFit.cover
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/partySplash.png',
            fit: BoxFit.scaleDown,
            scale: 8,
          ),
          const SizedBox(height: 40,),
          const SpinKitSpinningLines(
            color: Colors.white,
            size: 100,
          ),
        ]
      ),
    );
  }
}