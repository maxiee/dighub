import 'package:dighub/constant.dart';
import 'package:dighub/data/repo_cache.dart';
import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
      case kCreateEvent:
        return EventCard(child: CreateEventComp(widget.event));
      case kForkEvent:
        return EventCard(child: ForkEventComp(widget.event));
      case kIssueCommentEvent:
      case kIssuesEvent:
        return EventCard(child: IssueCommentEventComp(widget.event));
      case kPullRequestReviewCommentEvent:
      case kCommitCommentEvent:
      case kPullRequestReviewEvent:
      case kWatchEvent:
      case kGollumEvent:
      case kReleaseEvent:
      case kMemberEvent:
        return EventCard(child: BasicEventComp(widget.event));
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

class BasicEventComp extends StatelessWidget with EventCompCommons {
  final Event event;

  const BasicEventComp(this.event, {super.key});

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
              ]);
        },
        selector: (context, cache) => cache.getCache(event.repo?.name ?? ""),
        shouldRebuild: (previous, next) =>
            previous?.stargazersCount != next?.stargazersCount ||
            previous?.description != next?.description);
  }
}

class IssueCommentEventComp extends StatelessWidget with EventCompCommons {
  final Event event;

  const IssueCommentEventComp(this.event, {super.key});

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
                issueTitle(event)
              ]);
        },
        selector: (context, cache) => cache.getCache(event.repo?.name ?? ""),
        shouldRebuild: (previous, next) =>
            previous?.stargazersCount != next?.stargazersCount ||
            previous?.description != next?.description);
  }
}

class ForkEventComp extends StatelessWidget with EventCompCommons {
  final Event event;

  const ForkEventComp(this.event, {super.key});

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
              ]);
        },
        selector: (context, cache) => cache.getCache(event.repo?.name ?? ""),
        shouldRebuild: (previous, next) =>
            previous?.stargazersCount != next?.stargazersCount ||
            previous?.description != next?.description);
  }
}

class CreateEventComp extends StatelessWidget with EventCompCommons {
  final Event event;

  const CreateEventComp(this.event, {super.key});

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
              ]);
        },
        selector: (context, cache) => cache.getCache(event.repo?.name ?? ""),
        shouldRebuild: (previous, next) =>
            previous?.stargazersCount != next?.stargazersCount ||
            previous?.description != next?.description);
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

  Text issueTitle(Event event) {
    return Text(event.payload?['issue']['title'] ?? "");
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [Text(event.payload?['pull_request']['title'] ?? "")],
    );
  }

  InkWell repo(Repository? repo) {
    String repoName;
    if (repo != null && repo.fullName.isNotEmpty) {
      repoName = repo.fullName;
    } else {
      repoName = repo?.name ?? '';
    }
    return InkWell(
      onTap: () async {
        if (repo == null) return;
        final uri = Uri.parse(repo.htmlUrl);
        await launchUrl(uri);
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.book, color: Colors.grey.shade400),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                repoName,
                style: const TextStyle(color: Colors.purple),
              ),
            ),
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
      ]),
    );
  }
}
