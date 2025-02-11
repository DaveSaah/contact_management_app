import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            "Version: 1.0.0",
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
            children: [
              Text("Visit "),
              Text(
                "https://davesaah.web.app",
                style: TextStyle(
                  color: Colors.blueAccent,
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
            "This app allows users to add, edit, and delete contacts with ease. "
            "It provides a simple and user-friendly interface for managing personal contacts efficiently.",
          ),
        ],
      ),
    );
  }
}
