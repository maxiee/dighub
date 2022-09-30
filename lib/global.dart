import 'package:dighub/data/model/cached_repo.dart';
import 'package:github/github.dart';

import 'package:isar/isar.dart';
import 'data/repo_cache.dart';

class Global {
  static late GitHub gitHub;
  static late RepoCache repoCache;
  static late Isar isar;

  static void init() async {
    gitHub = GitHub();
    repoCache = RepoCache();
    isar = await Isar.open([CachedRepoSchema]);
  }
}