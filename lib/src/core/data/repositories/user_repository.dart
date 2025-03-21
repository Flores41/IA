import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coreia/src/core/data/models/user_model.dart';
import 'package:coreia/src/core/utils/password_encryption.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> registerUser(UserModel user) async {
    final hashedPassword = PasswordEncryption.encrypt(user.password);
    final newUser = user.copy(password: hashedPassword);

    await _firestore.collection('users').doc(user.id).set(newUser.toMap());

    return newUser;
  }

  Future<UserModel?> getUserByID(String userId) async {
    final querySnapshot = await _firestore.collection('users').where('id', isEqualTo: userId).limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      return UserModel.fromFirestore(querySnapshot.docs.first);
    }
    return null;
  }

  Future<bool> authenticateUser(String id, String password) async {
    final user = await getUserByID(id);

    if (user == null) {
      return false;
    }

    final hashedPassword = PasswordEncryption.encrypt(password);
    return user.password == hashedPassword;
  }
}
