import 'package:contact_management_app/models/models.dart';
import 'package:contact_management_app/services/service.dart';
import 'package:flutter/material.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreen();
}

class _ContactListScreen extends State<ContactListScreen> {
  @override
  Widget build(BuildContext context) {
    return ContactsListView();
  }
}

class ContactsListView extends StatelessWidget {
  const ContactsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ContactList>(
      future: fetchAllContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Unable to get contact list");
        } else if (!snapshot.hasData || snapshot.data!.contacts.isEmpty) {
          return Text("No contacts available");
        }

        List<Contact> contacts = snapshot.data!.contacts;
        return ContactListItems(contacts: contacts);
      },
    );
  }
}

class ContactListItems extends StatelessWidget {
  const ContactListItems({
    super.key,
    required this.contacts,
  });

  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];

        return ListTile(
          leading: CircleAvatar(
            child: Text(contact.pname[0]),
          ),
          title: Text(contact.pname),
          subtitle: Text(contact.pphone),
        );
      },
    );
  }
}
