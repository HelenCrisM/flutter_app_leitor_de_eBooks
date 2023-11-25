import 'package:app_leitor_de_ebooks/controller/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

// ignore: must_be_immutable
class CardWidget extends StatefulWidget {
  CardWidget({
    super.key,
    required this.title,
    required this.author,
    required this.coverImage,
    required this.downloadUrlImage,
    required this.isFavorite,
  });

  final String title;
  final String author;
  final String coverImage;
  final String downloadUrlImage;
  bool isFavorite;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  CardController controller = Get.put(CardController());

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 207, 180, 233),
            borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Stack(
          children: [
            Center(
              child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => controller.downloadBook(
                               widget.downloadUrlImage, widget.title),
                          child: Image.network(
                            widget.coverImage,
                          ),
                        ),
                        Text(
                          widget.title,
                          style: const TextStyle(
                              color: Color(0xff7b2cbf), fontSize: 16),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.author,
                          style: const TextStyle(
                            color: Color(0xffd4d4d4),
                          ),
                        )
                      ],
                    ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  widget.isFavorite = !widget.isFavorite;
                  setState(() {});
                },
                icon: const Icon(Icons.bookmark),
                color: widget.isFavorite ? Colors.redAccent : Colors.white,
              ),
            ),
          ],
        ),    
    );
  }
}
