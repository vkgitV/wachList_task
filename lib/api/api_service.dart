
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/model.dart';

class ApiService{
  final String baseUrl='http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts';

  Future<List<Contact>> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);

      return  jsonData.map((contact) => Contact.fromJson(contact)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}