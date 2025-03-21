import 'package:coreia/src/core/provider/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void register() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      userProvider.registerUser(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _nameController.text.trim(),
      );

      showSnackBarCustom(context, 'Usuario Agregado Correctamente');
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showSnackBarCustom(
        context,
        'Error Al registrar Al Usuario',
        color: Colors.amber,
      );
    }
  }

  void clearFormFields() {
    _emailController.clear();
    _passwordController.clear();
    _nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Usuario')),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 12,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El email es obligatorio';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Ingrese un email valido';
                  }
                  return null;
                },
                controller: _emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El password es obligatorio';
                  } else if (value.length < 6) {
                    return 'Minimo 8 caracteres';
                  }
                  return null;
                },
                controller: _passwordController,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El campo  es obligatorio';
                  } else if (value.length < 3) {
                    return 'Minimo 3 caracteres';
                  }
                  return null;
                },
                controller: _nameController,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              userProvider.isLoading
                  ? CircularProgressIndicator()
                  : TextButton(
                      onPressed: () {
                        register();
                        clearFormFields();
                      },
                      child: Text('Registrarse'),
                    ),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                child: Text(
                  "¿Ya tienes una cuenta? Inicia sesión".toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showSnackBarCustom(BuildContext context, String message, {Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: Duration(seconds: 2)),
  );
}
