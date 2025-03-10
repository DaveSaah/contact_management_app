import 'package:contact_management_app/screens/about.dart';
import 'package:contact_management_app/screens/add_contact.dart';
import 'package:contact_management_app/screens/contact_list.dart';
import 'package:flutter/material.dart';

/// Defines the initial page of the application.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Represents the navigation item
  int _selectedIndex = 0;

  static const _widgetOpts = [
    ContactListScreen(),
    AddContactScreen(),
    AboutScreen(),
  ];

  static const _appbarOpts = [
    "Contacts List",
    "Add Contact",
    "About",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appbarOpts[_selectedIndex],
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: _widgetOpts[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contacts List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
