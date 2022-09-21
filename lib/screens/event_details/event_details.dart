import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:party/model/event.dart';

class EventDetails extends StatefulWidget {
  EventDetails(this.event);
  Event event;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> with AutomaticKeepAliveClientMixin<EventDetails>{
  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.deepPurpleAccent[700],
          expandedHeight: 350,
          pinned: true,
          title: Text('event'.i18n()),
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(widget.event.image, fit: BoxFit.cover,),
          ),
        ),
        body(),
      ],
    ),
  );

  Widget body() => SliverToBoxAdapter(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(widget.event.title, style: TextStyle(color: Colors.grey[800], fontSize: 20, fontWeight: FontWeight.bold),),
        )
      ],
    ),
  );

  @override
  bool get wantKeepAlive => true;
  
}