import 'package:flutter/material.dart';

class Information {
  final String firstname, lastname, email, phone;
  final String? imageURL;

  Information(
      {required this.firstname,
      required this.lastname,
      required this.email,
      required this.phone,
      this.imageURL});
}

List<Information> info = List.generate(
  demo_data.length,
  (index) => Information(
      firstname: demo_data[index]['firstname'],
      lastname: demo_data[index]['lastname'],
      email: demo_data[index]['email'],
      phone: demo_data[index]['phone'],
      imageURL: demo_data[index]['imageURL']),
);

List demo_data = [
  {
    "firstname": "Nam",
    "lastname": "Tu",
    "email": "test@gmail.com",
    "phone": "9025806418",
    "imageURL": "assets/images/profile.png",
  },
  {
    "firstname": "Nam",
    "lastname": "Tu",
    "email": "test@gmail.com",
    "phone": "9025806418",
    "imageURL": "assets/images/profile.png",
  }
];
