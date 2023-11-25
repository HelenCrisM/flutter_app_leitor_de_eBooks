import 'package:app_leitor_de_ebooks/ui/pages/favorites_book_page.dart';
import 'package:app_leitor_de_ebooks/ui/pages/home_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const home = '/';
  static const favorite = 'favorite';
  static Route<MaterialPageRoute>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case 'favorite':
        return MaterialPageRoute(builder: (_) => const FavoritesBookPage());
    }
    return null;
  }
}
