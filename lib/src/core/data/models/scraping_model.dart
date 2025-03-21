import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coreia/src/core/domain/entities/scraping.dart';

class ScrapingModel extends Scraping {
  ScrapingModel({
    required super.id,
    required super.nombre,
    required super.color,
    required super.genero,
    required super.categoria,
    required super.imagen,
  });

  factory ScrapingModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;
    return ScrapingModel(
      id: snapshot.id,
      nombre: data?['nombre'],
      color: data?['color'],
      genero: data?['genero'],
      categoria: data?['categoria'],
      imagen: data?['imagen'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'color': color,
      'genero': genero,
      'categoria': categoria,
      'imagen': imagen,
    };
  }

  factory ScrapingModel.fromMap(Map<String, dynamic> map) {
    return ScrapingModel(
      id: map['id'],
      nombre: map['nombre'],
      color: map['color'],
      genero: map['genero'],
      categoria: map['categoria'],
      imagen: map['imagen'],
    );
  }
}
