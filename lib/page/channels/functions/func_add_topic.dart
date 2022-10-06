import 'package:dighub/data/channel/channel_manager.dart';
import 'package:dighub/data/model/channel_item.dart';
import 'package:dighub/global.dart';
import 'package:dighub/page/channels/subpage/channel_add_topic_page.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

void functionAddTopic(BuildContext context) async {
  String topicToAdd = await Navigator.of(context)
      .push(MaterialPageRoute(builder: ((context) => ChannelAddTopicPage())));

  if (topicToAdd.isEmpty) return;
  if (await Global.isar.channelItems
          .filter()
          .nameEqualTo(topicToAdd)
          .findFirst() !=
      null) return;

  await Global.isar.writeTxn(() async {
    await Global.isar.channelItems.put(
        ChannelItem(name: topicToAdd, type: ChannelType.topic, payload: ""));
  });

  Global.channelManager.initChannels();
}
