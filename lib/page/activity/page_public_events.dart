import 'dart:async';

import 'package:dighub/component/event_comp.dart';
import 'package:dighub/global.dart';
import 'package:dighub/widget/star_dighub.dart';
import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PublicEventsPage extends StatefulWidget {
  const PublicEventsPage({super.key});

  @override
  State<PublicEventsPage> createState() => _PublicEventsPageState();
}

class _PublicEventsPageState extends State<PublicEventsPage> {
  static const concurrentRepoFetchLimit = 5;
  StreamSubscription<Event>? eventStream;
  List<Event> events = [];

  int concurrentRepoFetchCount = 0;

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
    eventStream =
        Global.gitHub.activity.listPublicEvents(pages: 1).listen((event) {
      setState(() {
        events.add(event);
      });
    });
  }

  void loadRepoDetail(Event e) async {
    print("loadRepoDetail");

    String? repoName = e.repo?.name;
    if (repoName == null) return;

    if (Global.repoCache.contains(repoName)) return;

    final repoCached = await Global.repoCache.getCacheAndDB(repoName);
    if (repoCached != null) return;

    if (concurrentRepoFetchCount >= concurrentRepoFetchLimit) {
      print('loadRepoDetail limit');
      return;
    }

    concurrentRepoFetchCount++;
    final repoFetched = await Global.gitHub.repositories
        .getRepository(RepositorySlug.full(repoName));

    print(
        'on repo ${repoFetched.name}-${repoFetched.stargazersCount}-${repoFetched.description}');
    Global.repoCache.put(repoFetched);
    concurrentRepoFetchCount--;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: Text('Public Events'), actions: [StarDighub()]),
      body: ListView(
        children: events
            .map((e) => VisibilityDetector(
                key: ObjectKey(e),
                onVisibilityChanged: (info) {
                  var percent = info.visibleFraction;
                  if (percent > 0.1) {
                    loadRepoDetail(e);
                  }
                },
                child: EventComp(e)))
            .toList(),
      ),
    );
  }
}
