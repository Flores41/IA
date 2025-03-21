import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coreia/src/core/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.password,
    required super.name,
    required super.createdAt,
  });
  UserModel copy({
    String? id,
    String? email,
    String? password,
    String? name,
    Timestamp? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>?;

    return UserModel(
      id: documentSnapshot.id,
      email: data?['email'] ?? '',
      password: data?['password'] ?? '',
      name: data?['name'] ?? '',
      createdAt: (data?['createdAt'] as Timestamp?) ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> fromMap) {
    return UserModel(
      id: fromMap['id'] ?? '',
      email: fromMap['email'] ?? '',
      password: fromMap['password'] ?? '',
      name: fromMap['name'] ?? '',
      createdAt: fromMap['createdAt'] ?? '',
    );
  }
}
