import 'package:flutter/material.dart';

class PartyIcon extends StatelessWidget {
  PartyIcon(this.icon, {this.size = 24});
  IconData icon;
  double size;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.redAccent[400],
          Colors.deepPurpleAccent[700],
        ],
      ).createShader(bounds),
      child: Icon(icon, size: size,),
    );
  }
}