import 'package:github/github.dart';

class Global {
  static late GitHub gitHub;

  static void init() {
    gitHub = GitHub();
  }
}