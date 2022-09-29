import 'dart:async';

import 'package:dighub/global.dart';
import 'package:flutter/material.dart';
import 'package:github/github.dart';

class PublicEventsPage extends StatefulWidget {
  const PublicEventsPage({super.key});

  @override
  State<PublicEventsPage> createState() => _PublicEventsPageState();
}

class _PublicEventsPageState extends State<PublicEventsPage> {
  StreamSubscription<Event>? eventStream;
  List<Event> events = [];
  
  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  @override
  void dispose() {
    super.dispose();
    eventStream?.cancel();
  }

  void loadEvents() {
    eventStream = Global.gitHub.activity.listPublicEvents(pages: 5).listen((event) {
      setState(() {
        events.add(event);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Public Events')),
      body: ListView(
        children: events.map((e) => Text(e.toString())).toList(),
      ),
    );
  }
}