import 'package:dighub/global.dart';
import 'package:flutter/material.dart';

class StarDighub extends StatelessWidget {
  const StarDighub({super.key});

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
          if (Global.gitHub.rateLimitRemaining != null)
            Text('rateLimit remain ${Global.gitHub.rateLimitRemaining}')
        ],
      ),
    );
  }
}
