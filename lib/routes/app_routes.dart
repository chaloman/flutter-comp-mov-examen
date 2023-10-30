import 'package:flutter/material.dart';
import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'login';
  static Map<String, Widget Function(BuildContext)> routes = {
    'addUser': (BuildContext context) => const SignupScreen(),
    'login': (BuildContext context) => const LoginScreen(),
    'home': (BuildContext context) => const HomeScreen(),
    'providers': (BuildContext context) => const ListProviderScreen(),
    'providers/create-or-update': (BuildContext context) => const CreateProviderScreen(),
    'categories': (BuildContext context) => const ListCategoryScreen(),
    'categories/create-or-update': (BuildContext context) => const CreateCategoryScreen(),
    'products': (BuildContext context) => const ListProductScreen(),
    'products/create-or-update': (BuildContext context) => const CreateProductScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}