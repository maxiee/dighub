import 'package:dighub/widget/star_dighub.dart';
import 'package:flutter/material.dart';

class ChannelAddTopicPage extends StatefulWidget {
  const ChannelAddTopicPage({super.key});

  @override
  State<ChannelAddTopicPage> createState() => _ChannelAddTopicPageState();
}

class _ChannelAddTopicPageState extends State<ChannelAddTopicPage> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  onSaveTopic() {
    String text = controller.text;
    if (text.isEmpty) {
      return;
    }
    Navigator.of(context).pop(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Topic"), actions: [StarDighub()]),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Input topic to add'),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextField(
                controller: controller,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(onPressed: onSaveTopic, child: Text('Set'))
          ],
        ),
      ),
    );
  }
}
