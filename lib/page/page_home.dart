import 'package:dighub/page/activity/page_public_events.dart';
import 'package:dighub/page/token/page_set_token.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        children: [
          OutlinedButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PublicEventsPage())),
              child: Text('Public Events')),
          OutlinedButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SetTokenPage())),
              child: Text('Set Token'))
        ],
      ),
    );
  }
}
