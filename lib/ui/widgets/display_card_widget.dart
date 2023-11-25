import 'package:app_leitor_de_ebooks/models/book_model.dart';
import 'package:app_leitor_de_ebooks/services/book_service.dart';
import 'package:app_leitor_de_ebooks/ui/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget displayCardWidget(List<BookModel> list) {
  BookService service = Get.put(BookService());
  return GetBuilder<BookService>(
    builder: (newController) => ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: newController.listModel.length,
      itemBuilder: (context, index) {
        final item = service.listModel[index];
        return CardWidget(
          title: item.title,
          author: item.author,
          coverImage: item.coverUrl,
          downloadUrlImage: item.downloadUrl,
          isFavorite: false,
        );
      },
    ),
  );
}
