import 'dart:developer';

import 'package:coreia/src/core/data/models/scraping_model.dart';
import 'package:coreia/src/core/data/repositories/scraping_repository.dart';
import 'package:coreia/src/core/provider/gemini_provider.dart';
import 'package:flutter/foundation.dart';

class ScrapingProvider extends ChangeNotifier {
  final ScrapingRepository _repository;
  final GeminiProvider _geminiProvider;

//!CONSTRUCTOR
  ScrapingProvider({
    required ScrapingRepository repository,
    required GeminiProvider geminiProvider,
  })  : _repository = repository,
        _geminiProvider = geminiProvider;

  //!METODOS
  //* LISTA ORIGINAL SIN FILTROS
  List<ScrapingModel> _allScrapingList = [];
  // List<ScrapingModel> get allScrapingList => _filteredScrapingList;
  //*LISTA FILTRADA
  List<ScrapingModel> _filteredScrapingList = [];
  List<ScrapingModel> get allScrapingList => _filteredScrapingList;
  //*ESTADO DE CARGA
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  //*CATEGORIA SELECCIONADA
  String _selectedCategory = 'Todas';
  String get selectedCategory => _selectedCategory;
  //*GENERO SELECCIONADO
  String _selectedGender = 'Todos';
  String get selectedGender => _selectedGender;
  //*TEXTO DE BUSQUEDA
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  String get recommendation => _geminiProvider.response;
  List<String> get chatHistory => _geminiProvider.chatHistory;

  //!METODO PARA CARGAR DATOS DESDE FIRESTORE

  Future<void> fecthScrapingData() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allScrapingList = await _repository.getAllScrapingData();
      _applyFilters();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      log('Error al obtner datos $e');
    }
  }

  //!METODO PRIVADO  DE BUSQUEDAS Y FILTROS

  void _applyFilters() {
    //* Se filtran los elementos de la lista completa y se asignan a la lista filtrada.
    _filteredScrapingList = _allScrapingList.where(
      //* Para cada elemento de la lista, se evalúan los siguientes filtros:
      (element) {
        // * Si la categoría seleccionada es "Todas", no se filtra por categoría.
        //* Si no, se filtra para que coincida exactamente con la categoría seleccionada.
        //* Si la categoría seleccionada es "Ropa", solo pasa si element.categoria == "Ropa"
        final matchesCategory = _selectedCategory == 'Todas' || element.categoria == _selectedCategory;

        //* Si el género seleccionado es "Todos", no se filtra por género.
        //* Si no, se filtra para que coincida con el género (ignorando mayúsculas/minúsculas).
        //* Si el género seleccionado es "Mujer", solo pasa si element.genero == "Mujer"
        final matchesGender =
            _selectedGender == 'Todos' || element.genero.toLowerCase() == _selectedGender.toLowerCase();

        //* Si el campo de búsqueda está vacío, no se filtra por nombre.
        //* Si no, se filtra verificando que el nombre contenga el texto de búsqueda (ignorando mayúsculas/minúsculas).
        //* Si el usuario busca "Falda", solo pasa si element.nombre contiene "falda"
        //* Si el usuario busca "ROJO", el filtro verificará si esa palabra está dentro del nombre del producto.
        final matchesSearch = _searchQuery.isEmpty || element.nombre.toLowerCase().contains(_searchQuery.toLowerCase());

        //* Solo se incluyen los elementos que cumplan todas las condiciones.
        //* Devuelve solo los elementos que cumplen las tres condiciones
        return matchesCategory && matchesGender && matchesSearch;
      },
      //* Convierte el resultado filtrado en una lista y la asigna a _filteredScrapingList.
    ).toList();
    //* Notifica a los oyentes que la lista filtrada ha cambiado, para que se actualice la UI.
    notifyListeners();
  }

//! METODO PARA ACTUALIZAR BUSQUEDA

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  //! METODO PARA ACTUALIZAR CATEGORIA

  void updateCategory(String? category) {
    //* 👉 Si category es null, la función termina inmediatamente y no hace nada.
    if (category == null) {
      return;
    }
    //* 👉 Guarda el valor de category en _selectedCategory.
    _selectedCategory = category;

    //* 👉 Llama al método _applyFilters(); para aplicar el nuevo filtro de categoría.
    //* Esto significa que después de cambiar la categoría, se filtran los productos automáticamente.
    _applyFilters();
    notifyListeners();
  }

//! METODO PARA ACTUALZIAR EL GENERO
  void updateGender(String? gender) {
    if (gender == null) {
      return;
    }
    _selectedGender = gender;
    _applyFilters();
    notifyListeners();
  }

//! OBTENER TODAS LAS CATEGORIAS UNICAS SEGUN EL GENERO SELECCIONADO

//* 1️⃣ Filtramos por género con where

//*Dejamos solo los productos que coinciden con el género seleccionado (_selectedGender).
//*2️⃣ Extraemos las categorías con map

//*Convertimos la lista de productos en una lista de solo categorías.
//*3️⃣ Eliminamos categorías duplicadas con toSet()

//*Si hay varias veces "Ropa", dejamos solo una.
//*4️⃣ Agregamos "Todas" al inicio

//*Para que el usuario tenga la opción de ver todo.

  List<String> getCategories() {
    if (_selectedGender == 'Todos') {
      return ['Todas', ..._allScrapingList.map((e) => e.categoria).toSet()];
    } else {
      //* ✔️ Si _selectedGender = 'Todos', se muestran TODAS las categorías.
      //*  ✔️ Si el usuario elige un género específico, solo se muestran las categorías de ese género.
      //* ✔️ Se usa where() para filtrar por género.
      //* ✔️ Se usa .map() para extraer las categorías.
      //* ✔️ Se usa .toSet() para eliminar duplicados.
      //* ✔️ Se usa ... para expandir la lista y evitar listas anidadas.
      return [
        'Todas',
        ..._allScrapingList
            .where((element) => element.genero.toLowerCase() == _selectedGender.toLowerCase())
            .map((e) => e.categoria)
            .toSet()
      ];
    }
  }

  //! OBETNER OPCIONES DE GENERO

  List<String> getGenders() {
    return ['Todos', 'Hombre', 'Mujer'];
  }

  //! METODO PARA ENVIAR MENSAJE A GEMINI CON PRODCUTOS FILTRADOS

  Future<void> sendPromptToGemini(String userPrompt) async {
    _isLoading = true;
    notifyListeners();
    await _geminiProvider.fecthChatResponse(userPrompt, _filteredScrapingList);
    _isLoading = false;
    notifyListeners();
  }
}
