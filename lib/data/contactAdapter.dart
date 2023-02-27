import 'package:contact_app_hive_bloc_flutter/data/contactData.dart';
import 'package:hive/hive.dart';

class ContactAdapter extends TypeAdapter<ContactData> {
  @override
  final typeId = 0;

  @override
  ContactData read(BinaryReader reader) {
    return ContactData(reader.read() as String, reader.read() as String,
        reader.read() as String);
  }

  @override
  void write(BinaryWriter writer, ContactData obj) {
    writer.write(obj.lastName);
    writer.write(obj.firstName);
    writer.write(obj.phoneNumber);
  }
}
