import 'package:flutter/cupertino.dart';

import '../model/channel_item.dart';

class ChannelManager extends ChangeNotifier {
  List<ChannelItem> channels = [];

  initChannels() {
    channels = [
      ChannelItem(name: "What's new", type: ChannelType.whatsNew, payload: ''),
      ChannelItem(name: 'Add new topic', type: ChannelType.topic, payload: ''),
      ChannelItem(
          name: 'Add new lang', type: ChannelType.addLanguage, payload: ''),
      ChannelItem(
          name: 'Add new keyword', type: ChannelType.addKeyword, payload: ''),
      ChannelItem(
          name: 'Manage Subscribes', type: ChannelType.management, payload: '')
    ];
  }
}

class ChannelType {
  static const String whatsNew = 'whatsNew';
  static const String topic = 'topic';
  static const String language = 'language';
  static const String keyward = 'keyward';
  static const String addTopic = 'addTopic';
  static const String addLanguage = 'addLanguage';
  static const String addKeyword = 'addKeyword';
  static const String management = 'management';
}
