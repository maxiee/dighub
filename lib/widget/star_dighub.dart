import 'dart:async';

import 'package:dighub/global.dart';
import 'package:flutter/material.dart';

class StarDighub extends StatefulWidget {
  const StarDighub({super.key});

  @override
  State<StarDighub> createState() => _StarDighubState();
}

class _StarDighubState extends State<StarDighub> {
  late Timer rateLimitingTimer;
  int? rateLimit;

  @override
  void initState() {
    super.initState();
    rateLimit = Global.gitHub.rateLimitRemaining;
    rateLimitingTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        rateLimit = Global.gitHub.rateLimitRemaining;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    rateLimitingTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.yellow),
              Text(
                "maxiee/dighub",
                style: TextStyle(fontSize: 20, color: Colors.yellow),
              ),
              Icon(Icons.star, color: Colors.yellow),
            ],
          ),
          if (rateLimit != null)
            Text('rateLimit remain ${rateLimit}')
        ],
      ),
    );
  }
}
