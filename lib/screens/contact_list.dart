import 'package:contact_management_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Contact> fetchContact() async {
  final response = await http.get(Uri.parse(
    'https://apps.ashesi.edu.gh/contactmgt/actions/get_a_contact_mob?contid=6',
  ));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Contact.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreen();
}

class _ContactListScreen extends State<ContactListScreen> {
  late Future<Contact> futureContact;

  @override
  void initState() {
    super.initState();
    futureContact = fetchContact();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Contact>(
      future: futureContact,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.pname);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
