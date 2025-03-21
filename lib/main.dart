import 'package:coreia/firebase_options.dart';
import 'package:coreia/src/core/app/routes/app_routes.dart';
import 'package:coreia/src/core/data/repositories/user_repository.dart';
import 'package:coreia/src/core/provider/user_provider.dart';
import 'package:coreia/src/core/screens/auth/loading_screen.dart';
import 'package:coreia/src/core/screens/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'src/core/data/repositories/scraping_repository.dart';
import 'src/core/provider/provider.dart';
import 'src/core/screens/screens.dart';
import 'src/core/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final userRepository = UserRepository();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GeminiProvider()),
        ChangeNotifierProvider(
          create: (_) => ScrapingProvider(
            repository: ScrapingRepository(),
            geminiProvider: GeminiProvider(),
          ),
        ),
        ChangeNotifierProvider(create: (_) => UserProvider(userRepository)..checkLoginStatus()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: '/home',
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);

    debugPrint("🔄 Revisando estado de login... isCheckLogin = ${authProvider.isCheckLogin}");

    if (authProvider.isCheckLogin) {
      return LoadingScreen(); // 🔄 Muestra una pantalla de carga mientras verifica sesión
    }

    return authProvider.userModel != null ? HomeScreen() : LoginScreen();
  }
}
