import 'package:contact_management_app/custom/custom.dart';
import 'package:contact_management_app/services/service.dart';
import 'package:flutter/material.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
              validator: (value) =>
                  value == null || value.isEmpty ? "Enter a name" : null,
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
              validator: (value) => value == null || value.isEmpty
                  ? "Enter a phone number"
                  : null,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _saveContact,
                    child: Text("Save Contact"),
                  ),
          ],
        ),
      ),
    );
  }

  /// Clears input fields after submitting form
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveContact() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final phone = _phoneController.text.trim();

      if (phone.length != 10) {
        showErrorDialog(context, "Phone number must be exactly 10 digits.");
        return;
      }

      setState(() => _isLoading = true);

      try {
        await addContact(name, phone);
        _nameController.clear(); // Clear name field
        _phoneController.clear(); // Clear phone field

        // check if widget is mounted before using context
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Contact added successfully!"),
            ),
          );
        }
      } catch (e) {
        // check if widget is mounted before using context
        if (mounted) {
          showErrorDialog(
            context,
            "Failed to add contact. Please try again.",
          );
        }
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }
}
