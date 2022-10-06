import 'package:isar/isar.dart';

part 'channel_item.g.dart';

@collection
class ChannelItem {
  Id itemId = Isar.autoIncrement;

  String? name;
  String? type;
  String? payload;

  ChannelItem({required this.name, required this.type, required this.payload});
}