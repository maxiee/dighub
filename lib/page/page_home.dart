import 'package:dighub/page/activity/page_public_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
              child: Text('Public Events'))
        ],
      ),
    );
  }
}
