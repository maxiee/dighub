import 'package:dighub/data/model/channel_item.dart';
import 'package:dighub/global.dart';
import 'package:dighub/page/channels/comps/channel_comp_topic.dart';
import 'package:dighub/page/channels/comps/channel_comp_whats_new.dart';
import 'package:dighub/page/channels/functions/func_add_topic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/channel/channel_manager.dart';
import '../../widget/star_dighub.dart';

class ChannelsPage extends StatefulWidget {
  const ChannelsPage({super.key});

  @override
  State<ChannelsPage> createState() => _ChannelsPageState();
}

class _ChannelsPageState extends State<ChannelsPage> {
  ChannelItem? currentChannel;

  @override
  void initState() {
    super.initState();

    currentChannel = Global.channelManager.channels.first;
  }

  onChannelClicked(ChannelItem item) {
    switch (item.type) {
      case ChannelType.whatsNew:
        setState(() {
          currentChannel = item;
        });
        break;
      case ChannelType.topic:
        setState(() {
          currentChannel = item;
        });
        break;
      case ChannelType.addTopic:
        functionAddTopic(context);
        break;
    }
  }

  String getTitle() {
    switch (currentChannel?.type) {
      case ChannelType.whatsNew:
        return "What's new";
      case ChannelType.topic:
        return 'topic: ${currentChannel?.name ?? ""}';
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Container();

    switch (currentChannel?.type) {
      case ChannelType.whatsNew:
        body = ChannelCompWhatsNew(key: UniqueKey());
        break;
      case ChannelType.topic:
        body = ChannelCompTopic(key: UniqueKey(), topic: currentChannel!.name!);
        break; 
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: Text(getTitle()), actions: [StarDighub()]),
      body: Row(
        children: [
          Container(
              width: 150,
              child: Consumer<ChannelManager>(
                  builder: (context, channelManager, child) {
                return ListView(
                    children: channelManager.channels
                        .map((e) => OutlinedButton(
                            onPressed: () => onChannelClicked(e),
                            child: Text(e.name ?? '',
                                style: TextStyle(fontSize: 12))))
                        .toList());
              })),
          Container(width: 1, color: Colors.grey.shade400),
          Flexible(child: body)
        ],
      ),
    );
  }
}
