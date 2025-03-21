import 'package:coreia/src/core/utils/colors.dart';
import 'package:coreia/src/core/utils/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: const Color(0xFF101011),
      body: Center(
        child: Container(
          width: context.width * 0.3,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1F1F),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFF3a3a3b),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    Text(
                      'Iniciar Sesion'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🔹 Campos de Nombre, Email y Contraseña
                    CustomTextFormField(
                      controller: _nameController,
                      hint: 'Nombre',
                      validator: (value) => value!.isEmpty ? "El nombre es obligatorio" : null,
                    ),
                    const SizedBox(height: 20),

                    CustomTextFormField(
                      controller: _emailController,
                      hint: "Correo Electrónico",
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value!.contains('@') ? null : "Correo inválido",
                    ),
                    const SizedBox(height: 20),

                    CustomTextFormField(
                      controller: _passwordController,
                      hint: "Contraseña",
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (value) => value!.length >= 6 ? null : "Mínimo 6 caracteres",
                    ),
                    const SizedBox(height: 20),

                    const SizedBox(height: 20),

                    // 🔹 Botón de Registro

                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
                      child: Text(
                        "¿No tienes cuenta? Regístrate".toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
