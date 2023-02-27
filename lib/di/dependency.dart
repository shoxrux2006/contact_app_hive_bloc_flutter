import 'dart:io';
import 'package:contact_app_hive_bloc_flutter/data/contactAdapter.dart';
import 'package:contact_app_hive_bloc_flutter/util/const.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

final di = GetIt.instance;

Future<void> init() async {
  final document = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(document.path);
  Hive.registerAdapter(ContactAdapter());
  final box = await Hive.openBox(Const.boxName);
   di.registerSingleton(box);
}
