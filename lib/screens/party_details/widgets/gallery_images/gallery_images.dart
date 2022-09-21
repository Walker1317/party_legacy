import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:party/model/party.dart';
import 'package:party/screens/party_details/widgets/gallery_images/caroussel_images.dart';

class GalleryImages extends StatelessWidget {
  GalleryImages(this.party);
  Party party;

  @override
  Widget build(BuildContext context) {
    return 
    
    party.images.length < 2
    
    ?

    Padding(
      padding: const EdgeInsets.all(10),
      child: Text('empty_images'.i18n(), style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
    )

    :
    
    Container(
      height: 200,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: party.images.length,
        itemBuilder: (_, indice){

          String imageUrl = party.images[indice];

          return indice == 0 ? Container() : GestureDetector(
            onTap: (){

              showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.9),
                builder: (BuildContext context){

                  return CarousselImages(party.images, indice);

                }
              );

            },
            child: Container(
              height: 180,
              width: 160,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}