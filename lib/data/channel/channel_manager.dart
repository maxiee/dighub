import 'package:flutter/cupertino.dart';

class ChannelManager extends ChangeNotifier {
  List<ChannelItem> channels = [];

  initChannels() {
    channels = [
      ChannelItem(name: "What's new", type: ChannelType.whatsNew, payload: {}),
      ChannelItem(name: 'Add new topic', type: ChannelType.topic, payload: {}),
      ChannelItem(
          name: 'Add new lang', type: ChannelType.addLanguage, payload: {}),
      ChannelItem(
          name: 'Add new keyword', type: ChannelType.addKeyword, payload: {}),
      ChannelItem(
          name: 'Manage Subscribes', type: ChannelType.management, payload: {})
    ];
  }
}

enum ChannelType {
  whatsNew,
  topic,
  language,
  keyward,
  addTopic,
  addLanguage,
  addKeyword,
  management
}

class ChannelItem {
  String name;
  ChannelType type;
  Map<String, dynamic> payload;

  ChannelItem({required this.name, required this.type, required this.payload});
}
