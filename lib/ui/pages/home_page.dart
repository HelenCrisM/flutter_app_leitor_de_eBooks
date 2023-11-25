import 'package:app_leitor_de_ebooks/services/book_service.dart';
import 'package:app_leitor_de_ebooks/ui/widgets/display_card_widget.dart';
import 'package:app_leitor_de_ebooks/ui/widgets/header_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BookService service = Get.put(BookService());

  @override
  void initState() {
    service.getBook();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const HeaderTitleWidget(text: 'Today'),
      ),
      body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: displayCardWidget(service.listModel)
            
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'favorite');
        },
        child: const Icon(Icons.star),
      ),
    );
  }
}
