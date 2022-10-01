import 'package:dighub/widget/star_dighub.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetTokenPage extends StatefulWidget {
  const SetTokenPage({super.key});

  @override
  State<SetTokenPage> createState() => _SetTokenPageState();
}

class _SetTokenPageState extends State<SetTokenPage> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  onSaveToken() {
    final text = controller.text;
    if (text.isEmpty) return;
    SharedPreferences.getInstance()
        .then((sp) => sp.setString('token', text))
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('Token saved. Please restart app to make it work'))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Set Token"), actions: [StarDighub()]),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Input your GitHub token'),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextField(
                controller: controller,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(onPressed: onSaveToken, child: Text('Set'))
          ],
        ),
      ),
    );
  }
}
