import 'package:contact_management_app/models/models.dart';
import 'package:contact_management_app/services/service.dart';
import 'package:flutter/material.dart';

class EditContactDialog extends StatefulWidget {
  final Contact contact;

  const EditContactDialog({super.key, required this.contact});

  @override
  State<EditContactDialog> createState() => _EditContactDialogState();
}

class _EditContactDialogState extends State<EditContactDialog> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit Contact"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: "Phone"),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Cancel edit
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: _saveChanges,
          child: Text("Save"),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact.pname);
    _phoneController = TextEditingController(text: widget.contact.pphone);
  }

  void _saveChanges() {
    if (_phoneController.text.length != 10) {
      showErrorDialog(context, "Phone number must be exactly 10 digits.");
      return;
    }

    Navigator.of(context).pop(
      Contact(
        pid: widget.contact.pid,
        pname: _nameController.text,
        pphone: _phoneController.text,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Contact edited successfully!"),
      ),
    );
  }
}
