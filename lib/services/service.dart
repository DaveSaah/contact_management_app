import 'package:contact_management_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Contact> fetchContact() async {
  final response = await http.get(Uri.parse(
    'https://apps.ashesi.edu.gh/contactmgt/actions/get_a_contact_mob?contid=6',
  ));

  if (response.statusCode == 200) {
    return Contact.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load contact');
  }
}

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
