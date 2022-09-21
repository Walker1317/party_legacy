import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';

class CategoryIcon extends StatelessWidget {
  CategoryIcon(this.category, {this.flag = true, this.size = 14});
  String category;
  IconData icon;
  bool flag;
  double size;

  _setCategoryIcon(){

    switch (category) {
      case 'attractions':
        icon = Icons.attractions_outlined;
        break;
      case 'bars':
        icon = Ionicons.beer_outline;
        break;
      case 'coffee':
        icon = Iconsax.coffee;
        break;
      case 'fast_food':
        icon = Ionicons.fast_food_outline;
        break;
      case 'night_life':
        icon = Icons.nightlife_rounded;
        break;
      case 'pizzerias':
        icon = Ionicons.pizza_outline;
        break;
      case 'restaurant':
        icon = Ionicons.restaurant_outline;
        break;
      case 'others':
        icon = Ionicons.bookmark_outline;
        break;
      default:
    }

  }

  @override
  Widget build(BuildContext context) {
    _setCategoryIcon();

    return flag == true ? Positioned(
      right: 20,
      child: Container(
        height: 40,
        width: 20,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.redAccent[400],
              Colors.deepPurpleAccent[700],
            ],
          ),
        ),
        child: Icon(icon, color: Colors.white, size: 14,))
    ) : 
    Padding(
      padding: const EdgeInsets.all(10),
      child: Icon(icon, color: Colors.white, size: size,),
    );
  }
}