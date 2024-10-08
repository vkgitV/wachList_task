class Contact {
  final String name;
  final String contacts;

  Contact({
    required this.name,
    required this.contacts,
  });

  // Factory constructor to create a Contact object from a JSON map
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      contacts: json['Contacts'],
    );
  }

  // Method to convert a Contact object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'Contacts': contacts,
    };
  }
}
