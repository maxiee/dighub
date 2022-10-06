import 'package:dighub/page/channels/page_channels.dart';
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
                  MaterialPageRoute(builder: (context) => ChannelsPage())),
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
