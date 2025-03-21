import 'dart:convert';

import 'package:crypto/crypto.dart';

class PasswordEncryption {
  static String encrypt(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }
}
