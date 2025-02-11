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

Future<void> deleteContact(int id) async {
  final response = await http.post(
    Uri.parse(
      'https://apps.ashesi.edu.gh/contactmgt/actions/delete_contact',
    ),
    body: {'cid': id.toString()}, // Send as form data
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to delete contact');
  }
}

Future<void> editContact(Contact contact) async {
  final response = await http.post(
    Uri.parse(
      'https://apps.ashesi.edu.gh/contactmgt/actions/update_contact',
    ),
    body: {
      'cid': contact.pid.toString(),
      'cname': contact.pname,
      'cnum': contact.pphone,
    }, // Send as form data
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to edit contact');
  }
}

Future<void> addContact(String name, String phoneNumber) async {
  final response = await http.post(
    Uri.parse(
      'https://apps.ashesi.edu.gh/contactmgt/actions/add_contact_mob',
    ),
    body: {
      'ufullname': name,
      'uphonename': phoneNumber,
    }, // Send as form data
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to edit contact');
  }
}

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Error"),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("OK"),
        ),
      ],
    ),
  );
}
