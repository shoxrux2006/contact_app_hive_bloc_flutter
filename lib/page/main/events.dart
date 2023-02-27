import 'package:contact_app_hive_bloc_flutter/data/contactData.dart';

abstract class MainEvent {
  final ContactData data;
  MainEvent(this.data);
}
class MainDeleteEvent implements MainEvent {
  @override
  ContactData data;

  MainDeleteEvent(this.data);
}

class MainEditEvent implements MainEvent {
  @override
  final ContactData data;

  MainEditEvent(this.data);
}

class MainAddEvent implements MainEvent {
  @override
  final ContactData data;

  MainAddEvent(this.data);
}
