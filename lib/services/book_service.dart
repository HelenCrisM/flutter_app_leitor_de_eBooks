import 'dart:convert';

import 'package:app_leitor_de_ebooks/models/book_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BookService extends GetxController {
  static BookService get to => Get.find();
  List<BookModel> listModel = [];
  

  Future<Null> getBook() async {
    var url = Uri.parse('https://escribo.com/books.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (Map<String, dynamic> item in data) {
        listModel.add(BookModel.fromJson(item));
      }
      update();
    } else {
      throw Exception('Failed to load');
    }
  }
}
