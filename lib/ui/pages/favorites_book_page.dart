import 'package:app_leitor_de_ebooks/ui/widgets/header_title_widget.dart';
import 'package:flutter/material.dart';

class FavoritesBookPage extends StatefulWidget {
  const FavoritesBookPage({super.key});

  @override
  State<FavoritesBookPage> createState() => _FavoritesBookPageState();
}

class _FavoritesBookPageState extends State<FavoritesBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const HeaderTitleWidget(text: 'Today'),
      ),
      body: const Text('Favorite Page'));
  }
}