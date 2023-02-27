import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ContactData extends HiveObject {
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String lastName;
  @HiveField(2)
  String phoneNumber;

  ContactData(this.firstName, this.lastName, this.phoneNumber);
}
