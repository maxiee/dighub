
import 'package:flutter/material.dart';
import 'package:github/github.dart';

class RepoCache extends ChangeNotifier {
  var cache = <String, Repository>{};

  void put(Repository repo) {
    cache.update(repo.fullName, (repoInCache) => repo, ifAbsent: () => repo);
    notifyListeners();
  }

  Repository? get(String fullName) {
    return cache[fullName];
  }

  bool contains(String fullName) {
    return cache.containsKey(fullName);
  }
}
