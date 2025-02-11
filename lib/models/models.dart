class Contact {
  final int pid;
  final String pname;
  final String pphone;

  const Contact({
    required this.pid,
    required this.pname,
    required this.pphone,
  });

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
