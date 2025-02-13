class Contact {
  final int pid;
  final String pname;
  final String pphone;

  const Contact({
    required this.pid,
    required this.pname,
    required this.pphone,
  });

  /// Parses a json into a [Contact] object
  ///
  /// Throws [FormatException] if json schema doesn't match object fields
  factory Contact.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'pid': int userId,
        'pname': String pname,
        'pphone': String title,
      } =>
        Contact(
          pid: userId,
          pname: pname,
          pphone: title,
        ),
      _ => throw const FormatException('Failed to load contact.'),
    };
  }
}

class ContactList {
  final List<Contact> contacts;

  const ContactList({required this.contacts});

  /// Parses a json into a [ContactList] object
  factory ContactList.fromJson(List<dynamic> json) {
    return ContactList(
      contacts:
          json.map((e) => Contact.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
