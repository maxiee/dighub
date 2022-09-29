import 'package:dighub/constant.dart';
import 'package:flutter/material.dart';
import 'package:github/github.dart';

class EventComp extends StatefulWidget {
  final Event event;
  const EventComp(this.event, {super.key});

  @override
  State<EventComp> createState() => _EventCompState();
}

class _EventCompState extends State<EventComp> {
  @override
  Widget build(BuildContext context) {
    String? type = widget.event.type;
    switch (type) {
      case kPushEvent:
        return PushEventCard(child: PushEventComp(widget.event));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("id: ${widget.event.id}"),
        Text("type: ${widget.event.type}"),
        Text("repo: ${widget.event.repo}"),
        Text("actor: ${widget.event.actor}"),
        Text("org: ${widget.event.org}"),
        Text("payload: ${widget.event.payload}"),
      ],
    );
  }
}

class PushEventCard extends StatelessWidget {
  final Widget child;
  const PushEventCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(12),
      child: child,
    );
  }
}

class PushEventComp extends StatelessWidget with EventCompCommons {
  final Event event;

  const PushEventComp(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleRow(event),
          Divider(),
          repo(event),
          Divider(),
          commitDescriptions(event),
        ]);
  }
}

mixin EventCompCommons {
  Row titleRow(Event event) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.people, color: Colors.grey.shade400),
          SizedBox(width: 4),
          Text(event.actor?.login ?? "", style: TextStyle(color: Colors.blue)),
        ]),
        Text(event.type ?? ""),
      ],
    );
  }

  Column commitDescriptions(Event event) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: (event.payload?["commits"] as List)
            .map((e) =>
                Text((e["message"] as String?)?.replaceAll('\n', '') ?? ""))
            .toList()
            .take(5)
            .toList());
  }

  Column repo(Event event) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.book, color: Colors.grey.shade400),
            SizedBox(width: 4),
            Text(event.repo?.name ?? "",
                style: const TextStyle(color: Colors.purple)),
          ]),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.yellow),
              Text(event.repo?.stargazersCount.toString() ?? '')
            ],
          )
        ],
      ),
      if (event.repo?.description.isNotEmpty ?? false)
        Text(event.repo?.description ?? "")
    ]);
  }
}
