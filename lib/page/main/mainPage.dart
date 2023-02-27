import 'package:contact_app_hive_bloc_flutter/page/main/bloc.dart';
import 'package:contact_app_hive_bloc_flutter/page/main/states.dart';
import 'package:flutter/material.dart';

import '../../data/contactData.dart';
import 'events.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final bloc = MainBloc();

  @override
  void initState() {
    bloc.refresh();
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showAlertAddDialog(context);
              },
            ),
            body: StreamBuilder<MainState>(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  final state = snapshot.data ?? MainState(isLoading: true);
                  switch (state.status) {
                    case MainStatus.loading:
                      {
                        return const Center(child: CircularProgressIndicator());
                      }
                    case MainStatus.success:
                      {
                        final list = state.list;
                        return ListView.builder(
                            itemCount: state.list.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showAlertEditDialog(context, list[index]);
                                },
                                onLongPress: () {
                                  showAlertDeleteDialog(context, list[index]);
                                },
                                child: Column(children: [
                                  Text(list[index].lastName),
                                  Text(list[index].firstName),
                                  Text(list[index].phoneNumber)
                                ]),
                              );
                            });
                      }
                    case MainStatus.error:
                      {
                        return const Center(child: Text("nimadir xato bo'ldi"));
                      }
                  }
                })));
  }

  void showAlertDeleteDialog(BuildContext context, ContactData data) {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    Widget continueButton = TextButton(
      child: Text("ok"),
      onPressed: () {
        bloc.event.add(MainDeleteEvent(data));
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("delete contact"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showAlertEditDialog(BuildContext context, ContactData data) {
    final firstName = TextEditingController();
    final lastName = TextEditingController();
    final phoneNumber = TextEditingController();
    firstName.text = data.firstName;
    lastName.text = data.lastName;
    phoneNumber.text = data.phoneNumber;
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    Widget continueButton = TextButton(
      child: Text("ok"),
      onPressed: () {
        if (lastName.text.length > 2 &&
            firstName.text.length > 2 &&
            phoneNumber.text.length == 13) {
          final contact = data;
          contact.lastName = lastName.text;
          contact.phoneNumber = phoneNumber.text;
          contact.firstName = firstName.text;
          bloc.event.add(MainEditEvent(contact));
          Navigator.of(context).pop();
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("edit contact"),
      content: Column(
        children: [
          TextField(
            controller: firstName,
            decoration: const InputDecoration(hintText: "firstName"),
          ),
          TextField(
            controller: lastName,
            decoration: const InputDecoration(hintText: "lastName"),
          ),
          TextField(
            controller: phoneNumber,
            decoration: const InputDecoration(hintText: "phoneNumber"),
          )
        ],
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showAlertAddDialog(BuildContext context) {
    final firstName = TextEditingController();
    final lastName = TextEditingController();
    final phoneNumber = TextEditingController();
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    Widget continueButton = TextButton(
      child: Text("ok"),
      onPressed: () {
        if (lastName.text.length > 2 &&
            firstName.text.length > 2 &&
            phoneNumber.text.length == 13) {
          bloc.event.add(MainAddEvent(
              ContactData(firstName.text, lastName.text, phoneNumber.text)));
          Navigator.of(context).pop();
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Add contact"),
      content: Column(
        children: [
          TextField(
            controller: firstName,
            decoration: const InputDecoration(hintText: "firstName"),
          ),
          TextField(
            controller: lastName,
            decoration: const InputDecoration(hintText: "lastName"),
          ),
          TextField(
            controller: phoneNumber,
            decoration: const InputDecoration(hintText: "phoneNumber"),
          )
        ],
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
