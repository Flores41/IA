import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String email;
  final String password;
  final String name;
  final Timestamp createdAt;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.createdAt,
  });
}
