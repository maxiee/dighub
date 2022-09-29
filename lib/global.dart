import 'package:github/github.dart';

import 'data/repo_cache.dart';

class Global {
  static late GitHub gitHub;
  static late RepoCache repoCache;

  static void init() {
    gitHub = GitHub();
    repoCache = RepoCache();
  }
}