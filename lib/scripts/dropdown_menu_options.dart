import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localization/localization.dart';
import 'package:party/screens/widgets/party_icon.dart';

List<DropdownMenuItem<String>> categoryList = [

  DropdownMenuItem(
    value: 'attractions',
    child: Row(
      children: [
        PartyIcon(Icons.attractions_outlined),
        const SizedBox(width: 20,),
        Text('attractions'.i18n())
      ],
    ),
  ),

  DropdownMenuItem(
    value: 'bars',
    child: Row(
      children: [
        PartyIcon(Ionicons.beer_outline),
        const SizedBox(width: 20,),
        Text('bars'.i18n())
      ],
    ),
  ),

  DropdownMenuItem(
    value: 'coffee',
    child: Row(
      children: [
        PartyIcon(Iconsax.coffee),
        const SizedBox(width: 20,),
        Text('coffee'.i18n())
      ],
    ),
  ),

  DropdownMenuItem(
    value: 'fast_food',
    child: Row(
      children: [
        PartyIcon(Ionicons.fast_food_outline),
        const SizedBox(width: 20,),
        Text('fast_food'.i18n())
      ],
    ),
  ),

  DropdownMenuItem(
    value: 'night_life',
    child: Row(
      children: [
        PartyIcon(Icons.nightlife_rounded),
        const SizedBox(width: 20,),
        Text('night_life'.i18n())
      ],
    ),
  ),

  DropdownMenuItem(
    value: 'pizzerias',
    child: Row(
      children: [
        PartyIcon(Ionicons.pizza_outline),
        const SizedBox(width: 20,),
        Text('pizzerias'.i18n())
      ],
    ),
  ),

  DropdownMenuItem(
    value: 'restaurant',
    child: Row(
      children: [
        PartyIcon(Ionicons.restaurant_outline),
        const SizedBox(width: 20,),
        Text('restaurant'.i18n())
      ],
    ),
  ),

  DropdownMenuItem(
    value: 'others',
    child: Row(
      children: [
        PartyIcon(Ionicons.bookmark_outline),
        const SizedBox(width: 20,),
        Text('others'.i18n())
      ],
    ),
  ),

];



















  