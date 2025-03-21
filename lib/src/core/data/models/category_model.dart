import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coreia/src/core/domain/entities/category.dart';


class CategoryModel extends CategoryScraping {
  CategoryModel({
    required super.id,
    required super.name,
  });

  factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;
    return CategoryModel(
      id: snapshot.id,
      name: data?['name'],
    );
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': super.id,
      'name': super.name,
    };
  }
}
