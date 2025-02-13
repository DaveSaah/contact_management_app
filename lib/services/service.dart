import 'dart:io';
import 'package:contact_management_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Fetches all contacts from server.
///
/// Throws [HttpException] if request is unsuccessful.
Future<ContactList> fetchAllContacts() async {
  final response = await http.get(Uri.parse(
    'https://apps.ashesi.edu.gh/contactmgt/actions/get_all_contact_mob',
  ));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = jsonDecode(response.body);
    return ContactList.fromJson(jsonData);
  } else {
    throw HttpException('Failed to load contacts');
  }
}

/// Deletes a contact using [id].
///
/// throws [HttpException] if request is unsuccessful.
Future<void> deleteContact(int id) async {
  final response = await http.post(
    Uri.parse(
      'https://apps.ashesi.edu.gh/contactmgt/actions/delete_contact',
    ),
    body: {'cid': id.toString()}, // Send as form data
  );

  if (response.statusCode != 200) {
    throw HttpException('Failed to delete contact');
  }
}

/// Edits a contact.
///
/// throws [HttpException] if request is unsuccessful.
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
    throw HttpException('Failed to edit contact');
  }
}

/// Adds a contact using [name] and [phoneNumber].
///
/// throws [HttpException] if request is unsuccessful.
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
    throw HttpException('Failed to edit contact');
  }
}
