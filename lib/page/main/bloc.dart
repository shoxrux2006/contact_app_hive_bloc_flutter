import 'dart:async';

import 'package:contact_app_hive_bloc_flutter/data/contactData.dart';
import 'package:contact_app_hive_bloc_flutter/di/dependency.dart';
import 'package:contact_app_hive_bloc_flutter/page/main/events.dart';
import 'package:contact_app_hive_bloc_flutter/page/main/states.dart';
import 'package:hive/hive.dart';

class MainBloc {
  final _eventController = StreamController<MainEvent>();
  final _stateController = StreamController<MainState>();
  final _box = di.get<Box>();
  List<ContactData> _contactList = List.empty();

  MainBloc() {
    _eventController.stream.listen((event) async {
      if (event is MainDeleteEvent) {
        _deleteContact(event.data);
      } else if (event is MainAddEvent) {
        _addContact(event.data);
      } else {
        if (event is MainEditEvent) {
          _editContact(event.data);
        }
      }
    });
  }

  void refresh() async {
    _contactList = _box.values.map((e) => e as ContactData).toList();
    _stateController
        .add(MainState(list: _contactList, status: MainStatus.success));
  }

  void _addContact(ContactData contactData) async {
    _stateController.add(MainState(isLoading: true));
    await _box.add(contactData);
    refresh();
  }

  void _deleteContact(ContactData contactData) async {
    _stateController.add(MainState(isLoading: true));
    await _box.delete(contactData.key);
    refresh();
  }

  void _editContact(ContactData contactData) async {
    await _box.put(contactData.key, contactData);
    refresh();
  }

  void close() {
    _stateController.close();
    _eventController.close();
  }

  StreamSink<MainEvent> get event => _eventController.sink;

  Stream<MainState> get stream => _stateController.stream;
}
