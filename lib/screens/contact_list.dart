import 'package:contact_management_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<ContactList> fetchAllContacts() async {
  final response = await http.get(Uri.parse(
    'https://apps.ashesi.edu.gh/contactmgt/actions/get_all_contact_mob',
  ));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = jsonDecode(response.body);
    return ContactList.fromJson(jsonData);
  } else {
    throw Exception('Failed to load contacts');
  }
}

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreen();
}

class _ContactListScreen extends State<ContactListScreen> {
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
      },
    );
  }
}
