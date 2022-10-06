import 'package:dighub/component/event_comp.dart';
import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoComp extends StatefulWidget {
  final Repository repository;
  const RepoComp({super.key, required this.repository});

  @override
  State<RepoComp> createState() => _RepoCompState();
}

class _RepoCompState extends State<RepoComp> {
  Row titleRow(Repository repo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.people, color: Colors.grey.shade400),
          SizedBox(width: 4),
          Text(repo.owner?.login ?? "", style: TextStyle(color: Colors.blue)),
        ]),
      ],
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

  @override
  Widget build(BuildContext context) {
    return EventCard(child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleRow(widget.repository),
        Divider(),
        repo(widget.repository)
      ]));
  }
}