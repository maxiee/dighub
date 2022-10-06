import 'dart:async';

import 'package:dighub/component/repo_comp.dart';
import 'package:dighub/global.dart';
import 'package:flutter/material.dart';
import 'package:github/github.dart';

class ChannelCompTopic extends StatefulWidget {
  final String topic;

  const ChannelCompTopic({super.key, required this.topic});

  @override
  State<ChannelCompTopic> createState() => _ChannelCompTopicState();
}

class _ChannelCompTopicState extends State<ChannelCompTopic> {
  StreamSubscription<Repository>? repositoriesStream;
  List<Repository> repositories = [];

  @override
  void initState() {
    super.initState();
    loadTopics();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadTopics() {
    repositoriesStream?.cancel();
    repositories.clear();
    repositoriesStream = Global.gitHub.search
        .repositories('${widget.topic} in:topics', sort: 'updated')
        .listen((repo) {
      if (repo.stargazersCount == 0) return;
      setState(() {
        repositories.add(repo);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ListView(
          children: repositories.map((e) => RepoComp(repository: e)).toList()),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh), onPressed: () => loadTopics()),
    );
  }
}
