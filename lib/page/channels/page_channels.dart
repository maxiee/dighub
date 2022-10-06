import 'package:dighub/data/model/channel_item.dart';
import 'package:dighub/global.dart';
import 'package:dighub/page/channels/comps/channel_comp_whats_new.dart';
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
  @override
  Widget build(BuildContext context) {
    Widget body = Container();

    switch(currentChannel?.type) {
      case ChannelType.whatsNew:
        body = ChannelCompWhatsNew();
        break;
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: Text('Public Events'), actions: [StarDighub()]),
      body: Row(
        children: [
          Container(width: 150, child: Consumer<ChannelManager>(builder: (context, channelManager, child) {
            return ListView(
              children: channelManager.channels.map(
                (e) => OutlinedButton(onPressed: () => null, child: Text(e.name ?? '', style: TextStyle(fontSize: 12)))).toList());
          })),
          Container(width: 1, color: Colors.grey.shade400),
          Flexible(
            child: body
          )
        ],
      ),
    );
  }
}