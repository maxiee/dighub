import 'package:dighub/data/channel/channel_manager.dart';
import 'package:dighub/data/model/cached_repo.dart';
import 'package:dighub/data/model/channel_item.dart';
import 'package:github/github.dart';

import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/repo_cache.dart';

class Global {
  static late GitHub gitHub;
  static late RepoCache repoCache;
  static late Isar isar;
  static late ChannelManager channelManager;
  static bool inited = false;

  static Future<void> init() async {
    if (inited) {
      return;
    }

    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token');
    if (token == null) {
      gitHub = GitHub();
    } else {
      gitHub = GitHub(auth: Authentication.withToken(token));
    }

    repoCache = RepoCache();
    isar = await Isar.open([CachedRepoSchema, ChannelItemSchema]);

    channelManager = ChannelManager();
    await channelManager.initChannels();

    inited = true;
  }
}
