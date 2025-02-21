import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String _url = "https://davesaah.web.app";

    Future<void> _launchURL() async {
      if (await canLaunchUrl(Uri.parse(_url))) {
        await launchUrl(
          Uri.parse(_url),
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $_url';
      }
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.contact_phone,
              size: 100,
              color: Colors.deepPurpleAccent,
            ),
            Text(
              "Contact Management App",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Version: 1.0.2",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Divider(
              thickness: 1,
              height: 20,
            ),
            Text(
              "Developer Info",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text("Name: David Abeiku Saah"),
            Text("Student ID: 72522025"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Visit "),
                InkWell(
                  onTap: _launchURL,
                  child: Text(
                    _url,
                    style: TextStyle(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                Text(" for more info"),
              ],
            ),
            Divider(
              thickness: 1,
              height: 20,
            ),
            Text(
              "App Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              """This app allows users to add, edit, and delete contacts 
with ease. It provides a simple and user-friendly interface
for managing personal contacts efficiently.
              """,
            ),
          ],
        ),
      ),
    );
  }
}
