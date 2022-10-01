import 'dart:async';

import 'package:dighub/component/event_comp.dart';
import 'package:dighub/constant.dart';
import 'package:dighub/global.dart';
import 'package:dighub/widget/star_dighub.dart';
import 'package:flutter/material.dart';
import 'package:github/github.dart';

class PublicEventsPage extends StatefulWidget {
  bool filterZeroStar;
  PublicEventsPage({super.key, this.filterZeroStar = false});

  @override
  State<PublicEventsPage> createState() => _PublicEventsPageState();
}

class _PublicEventsPageState extends State<PublicEventsPage> {
  static const concurrentRepoFetchLimit = 5;
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
    eventStream?.cancel();
    events.clear();

    eventStream =
        Global.gitHub.activity.listPublicEvents(pages: 1).listen((event) {
      if (event.type == kDeleteEvent) {
        return;
      }
      loadRepoDetail(event).then((repoFetched) {
        if (repoFetched == null) {
          return;
        }
        if (widget.filterZeroStar) {
          if (repoFetched.stargazersCount == 0) {
            return;
          }
        }
        setState(() {
          events.add(event);
        });
      });
    });
  }

  Future<Repository?> loadRepoDetail(Event e) async {
    print("loadRepoDetail");

    String? repoName = e.repo?.name;
    if (repoName == null) return null;

    if (Global.repoCache.contains(repoName)) {
      print('loadRepoDetail cache memory');
      return Global.repoCache.getCache(repoName);
    }

    final repoCached = await Global.repoCache.getCacheAndDB(repoName);
    if (repoCached != null) {
      print('loadRepoDetail cache db');
      return repoCached;
    }

    try {
      final repoFetched = await Global.gitHub.repositories
          .getRepository(RepositorySlug.full(repoName));

      print(
          'on repo ${repoFetched.name}-${repoFetched.stargazersCount}-${repoFetched.description}');
      Global.repoCache.put(repoFetched);

      return repoFetched;
    } on RepositoryNotFound {
      return null;
    } on Exception {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: Text('Public Events'), actions: [StarDighub()]),
      body: ListView(
        children: events.map((e) => EventComp(e)).toList(),
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.refresh), onPressed: loadEvents),
    );
  }
}
