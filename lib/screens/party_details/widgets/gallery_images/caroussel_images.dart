import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:party/model/party.dart';

class CarousselImages extends StatefulWidget {
  CarousselImages(this.listImages, this.indice);
  List<dynamic> listImages;
  int indice;

  @override
  _CarousselImagesState createState() => _CarousselImagesState();
}

class _CarousselImagesState extends State<CarousselImages> {
  int _current = 0;

  List<T> map<T>(List list, Function handler){

    List<T> result = [];
    for (var i = 0; i < list.length; i++){
      result.add(handler(i, list[i]));
    }
    return result;

  }

  @override
  void initState() {
    super.initState();
    _current = widget.indice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: ()=> Navigator.of(context).pop(),
            icon: const Icon(Ionicons.close)
          ),
        ],
        backgroundColor: Colors.transparent,
        leading: Container(),
      ),
      body: CarouselSlider.builder(
        itemCount: widget.listImages.length,
        options: CarouselOptions(
          initialPage: widget.indice,
          height: MediaQuery.of(context).size.height,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          onPageChanged: (index, pageReason){
            setState(() {
              _current = index;
            });
          }
        ),
        itemBuilder: (_, indice, indice2){

          String imageUrl = widget.listImages[indice];

          return InteractiveViewer(
            child: ClipRRect(
              child: Image.network(imageUrl, ),
            ),
          );

        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: map<Widget>(
          widget.listImages, (index, url){
            return Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? Colors.deepPurpleAccent[700] : Colors.grey[300]
              ),
            );
          }
        ),
      ),
    );
  }
}