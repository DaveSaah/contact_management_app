import 'package:contact_management_app/models/models.dart';
import 'package:contact_management_app/services/service.dart';
import 'package:flutter/material.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  @override
  Widget build(BuildContext context) {
    return ContactsListView();
  }
}

class ContactsListView extends StatefulWidget {
  const ContactsListView({
    super.key,
  });

  @override
  State<ContactsListView> createState() => _ContactsListViewState();
}

class _ContactsListViewState extends State<ContactsListView> {
  late Future<ContactList> _contactList;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  void _fetchContacts() {
    setState(() {
      _contactList = fetchAllContacts();
    });
  }

  Future<void> _deleteContact(int id) async {
    await deleteContact(id);
    _fetchContacts(); // Refresh contacts after deletion
  }

  Future<void> _refreshContacts() async {
    _fetchContacts(); // Refresh contacts on pull-down
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ContactList>(
      future: _contactList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Unable to get contact list");
        } else if (!snapshot.hasData || snapshot.data!.contacts.isEmpty) {
          return Text("No contacts available");
        }

        return RefreshIndicator(
          onRefresh: _refreshContacts,
          child: ContactListItems(
            contacts: snapshot.data!.contacts,
            onDelete: _deleteContact,
          ),
        );
      },
    );
  }
}

class ContactListItems extends StatefulWidget {
  const ContactListItems({
    super.key,
    required this.contacts,
    required this.onDelete,
  });

  final List<Contact> contacts;
  final Function(int) onDelete;

  @override
  State<ContactListItems> createState() => _ContactListItemsState();
}

class _ContactListItemsState extends State<ContactListItems> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.contacts.length,
      itemBuilder: (context, index) {
        final contact = widget.contacts[index];

        return ListTile(
          leading: CircleAvatar(
            child: Text(contact.pname[0]),
          ),
          title: Text(contact.pname),
          subtitle: Text(contact.pphone),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                onPressed: () => widget.onDelete(contact.pid),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
