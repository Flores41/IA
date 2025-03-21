import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coreia/src/core/data/models/user_model.dart';
import 'package:coreia/src/core/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:uuid/uuid.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _repository;
  UserProvider(this._repository);

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  bool _isCheckLogin = false;
  bool get isCheckLogin => _isCheckLogin;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  Future<void> registerUser(String email, String password, String name) async {
    try {
      _isLoading = true;
      notifyListeners();
      final uuid = const Uuid().v4();
      final newUser = UserModel(
        id: uuid,
        email: email,
        password: password,
        name: name,
        createdAt: Timestamp.now(),
      );
      await _repository.registerUser(newUser);
      _userModel = newUser;
      log('NUEVO USUSARIO REGISTRADO CON EXITO ${newUser.id}');
      await saveSession(_userModel!);

      _isLoading = false;
      _isCheckLogin = false;
      notifyListeners();
    } catch (e) {
      log('ERROR AL REGISTRAR AL USUARIO $e');
      notifyListeners();
    }
  }

  Future<void> saveSession(UserModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    log('Guardando la sesion del usuario  ${user.id}');

    await prefs.setString('userId', user.id);
  }

  Future<void> logout() async {
    _userModel = null;
    _isCheckLogin = false;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    _isCheckLogin = true;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');

    log('Verificando sesion ....El ID guardado es $userId');

    if (userId == null) {
      log('No hay sesión guardada. Redirigiendo al login...');
      _isCheckLogin = false;
      notifyListeners();
      return;
    }

    final user = await _repository.getUserByID(userId);

    if (user != null) {
      _userModel = user;
      log('Usuario encontrado en sesion ${_userModel!.id}');
    } else {
      log('Usuario no encontrado en Firestore');
      await prefs.remove('userId'); // Eliminar sesión inválida
    }

    _isCheckLogin = false;
    notifyListeners();
  }

  Future<bool> login(String id, String password, BuildContext context) async {
    final isValid = await _repository.authenticateUser(id, password);

    if (isValid) {
      _userModel = await _repository.getUserByID(id);

      await saveSession(_userModel!);

      _isCheckLogin = false;
      notifyListeners();

      return true;
    }

    return false;
  }
}
