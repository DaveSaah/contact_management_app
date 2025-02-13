import 'package:contact_management_app/custom/custom.dart';
import 'package:contact_management_app/models/models.dart';
import 'package:contact_management_app/screens/edit_contact.dart';
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

class ContactListItems extends StatefulWidget {
  final List<Contact> contacts;

  final Function(int) onDelete;
  final Function(Contact) onEdit;
  const ContactListItems({
    super.key,
    required this.contacts,
    required this.onDelete,
    required this.onEdit,
  });

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
            child: Text(contact.pname.isNotEmpty ? contact.pname[0] : "?"),
          ),
          title: Text(contact.pname),
          subtitle: Text(contact.pphone),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => widget.onEdit(contact), // open edit dialog
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

class _ContactsListViewState extends State<ContactsListView> {
  late Future<ContactList> _contactList;

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
            onEdit: _editContact,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _deleteContact(int id) async {
    bool confirmDelete = await _showDeleteConfirmationDialog();

    if (confirmDelete) {
      try {
        await deleteContact(id);
        _fetchContacts(); // Refresh contacts after deletion
      } catch (e) {
        // check if widget is mounted before using context
        if (mounted) {
          showErrorDialog(
            context,
            "Failed to delete contact. Please try again.",
          );
        }
      }
    }
  }

  Future<void> _editContact(Contact contact) async {
    final updatedContact = await showDialog<Contact>(
      context: context,
      builder: (context) => EditContactDialog(contact: contact),
    );

    if (updatedContact != null) {
      try {
        await editContact(updatedContact);
        _fetchContacts(); // Refresh contacts after update
      } catch (e) {
        // check if widget is mounted before using context
        if (mounted) {
          showErrorDialog(
            context,
            "Failed to edit contact. Please try again.",
          );
        }
      }
    }
  }

  void _fetchContacts() {
    setState(() {
      _contactList = fetchAllContacts();
    });
  }

  /// Refresh contacts on pull-down
  Future<void> _refreshContacts() async {
    _fetchContacts();
  }

  Future<bool> _showDeleteConfirmationDialog() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Confirm Deletion"),
            content: Text("Are you sure you want to delete this contact?"),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), // Cancel deletion
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // Confirm deletion
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
