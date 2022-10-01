import 'package:dighub/global.dart';
import 'package:dighub/page/page_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    Global.init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Global.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: Global.repoCache)
              ],
              child: MaterialApp(
                  debugShowCheckedModeBanner: false, home: HomePage()));
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
