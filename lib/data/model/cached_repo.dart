
import 'dart:convert';

import 'package:github/github.dart';
import 'package:isar/isar.dart';

part 'cached_repo.g.dart';

@collection
class CachedRepo {
  Id dbId = Isar.autoIncrement;

  @Index(type: IndexType.value)
  String? fullName;

  String? json;

  Repository toRespository() {
    return Repository.fromJson(jsonDecode(json!));
  }
}