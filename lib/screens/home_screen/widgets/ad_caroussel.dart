import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:party/model/ad.dart';
import 'package:party/party_widgets/loading_state/party_build_loading.dart';

class ADCaroussel extends StatefulWidget {
  const ADCaroussel({ Key key }) : super(key: key);

  @override
  _ADCarousselState createState() => _ADCarousselState();
}

class _ADCarousselState extends State<ADCaroussel> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  int _current = 0;

  Future<Stream<QuerySnapshot>> _adicionarListenerUsuarios() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db.collection('ads')
    .orderBy('priority')
    .snapshots();
    

    stream.listen((dados) {
      _controller.add(dados);
    });

  }


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
    _adicionarListenerUsuarios();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _controller.stream,
      builder: (context, snapshot){
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return PartyBuildLoading(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:

            if(snapshot.hasError){
              return const Text('Erro ao carregar');
            }

            QuerySnapshot querySnapshot = snapshot.data;
            List<DocumentSnapshot> usuarios = querySnapshot.docs.toList();

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: querySnapshot.docs.length,
                    options: CarouselOptions(
                      height: 100.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      autoPlayAnimationDuration: const Duration(milliseconds: 400),
                      autoPlayInterval: const Duration(seconds: 3),
                      viewportFraction: 0.95,
                      enableInfiniteScroll: true,
                      initialPage: 0,
                      onPageChanged: (index, pageReason){

                        setState(() {
                          _current = index;
                        });

                      }
                    ),
                    itemBuilder: (_, indice, indice2){

                      List<DocumentSnapshot> ads = querySnapshot.docs.toList();
                      DocumentSnapshot documentSnapshot = ads[indice];
                      AD ad = AD.fromDocumentSnapshot(documentSnapshot);

                      return Container(
                        width: MediaQuery.of(context).size.width,
                        //margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                          image: ad.image != null ? DecorationImage(
                            image: NetworkImage(ad.image),
                            fit: BoxFit.cover
                          ) : null
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(
                      querySnapshot.docs.toList(), (index, url){
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
                ],
              ),
            );
        } return Container();
      }
    );
  }
}