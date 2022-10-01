import 'package:dighub/constant.dart';
import 'package:dighub/data/repo_cache.dart';
import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:provider/provider.dart';

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
        return EventCard(child: PushEventComp(widget.event));
      case kPullRequestEvent:
        return EventCard(child: PullRequestEventComp(widget.event));
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

class EventCard extends StatelessWidget {
  final Widget child;
  const EventCard({super.key, required this.child});

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

class PullRequestEventComp extends StatelessWidget with EventCompCommons {
  final Event event;

  const PullRequestEventComp(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<RepoCache, Repository?>(
        builder: (context, value, child) {
          Repository? r = value ?? event.repo;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleRow(event),
              Divider(),
              repo(r),
              Divider(),
              pullRequestDescription(event)
            ],
          );
        },
        selector: (context, cache) => cache.getCache(event.repo?.name ?? ""),
        shouldRebuild: (previous, next) =>
            previous?.stargazersCount != next?.stargazersCount ||
            previous?.description != next?.description);
  }
}

class PushEventComp extends StatelessWidget with EventCompCommons {
  final Event event;

  const PushEventComp(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<RepoCache, Repository?>(
        builder: (context, value, child) {
          Repository? r = value ?? event.repo;
          return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleRow(event),
                Divider(),
                repo(r),
                Divider(),
                commitDescriptions(event),
              ]);
        },
        selector: (context, cache) => cache.getCache(event.repo?.name ?? ""),
        shouldRebuild: (previous, next) =>
            previous?.stargazersCount != next?.stargazersCount ||
            previous?.description != next?.description);
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

  Column pullRequestDescription(Event event) {
    print(event.payload);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(event.payload?['pull_request']['title'] ?? "")
        ],
    );
  }

  Column repo(Repository? repo) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.book, color: Colors.grey.shade400),
            SizedBox(width: 4),
            Text(repo?.name ?? "",
                style: const TextStyle(color: Colors.purple)),
          ]),
          if (repo?.description != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.yellow),
                Text(repo?.stargazersCount.toString() ?? '')
              ],
            )
        ],
      ),
      if (repo?.description.isNotEmpty ?? false)
        Text(repo?.description ?? "Loading...")
    ]);
  }
}
