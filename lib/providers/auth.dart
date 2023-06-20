import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Profile {
  int id;
  String username;
  String email;
  String firstName;
  String lastName;
  String gender;
  String image;
  String token;

  Profile({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.token,
  });
}

class Auth with ChangeNotifier {
  late Profile _profile;

  Profile get profile {
    return _profile;
  }

  Future<void> loginAPI(String username, String password) async {
    print('login');
    var url = Uri.https(
      'dummyjson.com',
      'auth/login',
    );
    try {
      final response = await http.post(url,
          body: jsonEncode({"username": username, "password": password}),
          headers: {'Content-Type': 'application/json'});
      final data = jsonDecode(response.body);
      print(data);
      // if (data.message) {
        
      // }

      _profile = Profile(
        id: data['id'],
        username: data['username'],
        email: data['email'],
        firstName: data['firstName'],
        lastName: data['lastName'],
        gender: data['gender'],
        image: data['image'],
        token: data['token'],
      );
    } catch (error) {
      // print("error");
      // print(error);
      // return;
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}
