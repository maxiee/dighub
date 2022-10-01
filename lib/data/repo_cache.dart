import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:dighub/data/model/cached_repo.dart';
import 'package:dighub/global.dart';
import 'package:flutter/material.dart';
import 'package:github/github.dart';

class RepoCache extends ChangeNotifier {
  var cache = <String, Repository>{};

  void put(Repository repo) async {
    // print('put name=${repo.name} fullName=${repo.fullName}');

    var repoInCache = cache[repo.fullName];

    if (repoInCache == null ||
        repoInCache.stargazersCount != repo.stargazersCount ||
        repoInCache.description != repo.description) {
      cache[repo.fullName] = repo;
      await Global.isar.writeTxn(() async {
        await Global.isar.cachedRepos.put(CachedRepo()
          ..fullName = repo.fullName
          ..json = jsonEncode(repo.toJson()));
      });
    }

    notifyListeners();
  }

  Future<Repository?> getCacheAndDB(String fullName) async {
    // print('getCacheAndDB fullName=${fullName}');
    if (cache.containsKey(fullName)) {
      return getCache(fullName);
    }

    final repoCached = await Global.isar.cachedRepos
        .filter()
        .fullNameEqualTo(fullName)
        .findFirst();

    if (repoCached != null) {
      cache[fullName] = repoCached.toRespository();
      return getCache(fullName);
    }

    return null;
  }

  Repository? getCache(String fullName) {
    return cache[fullName];
  }

  bool contains(String fullName) {
    return cache.containsKey(fullName);
  }
}
