import 'package:examen_flutter/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'routes/app_routes.dart';
import 'services/auth_service.dart';
import 'services/category_service.dart';
import 'services/product_service.dart';
import 'services/provider_service.dart';
import 'package:provider/provider.dart'; 

void main() {
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ProductService()),
        ChangeNotifierProvider(create: (_) => CategoryService()),
        ChangeNotifierProvider(create: (_) => ProviderService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Módulos Examen',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: AppTheme.appTheme,

    );
  }
}
