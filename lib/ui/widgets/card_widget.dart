import 'dart:developer';
import 'dart:io';

import 'package:app_leitor_de_ebooks/controller/card_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
  Dio dio = Dio();
  String filePath = "";

  @override
  void initState() {
    download();
    super.initState();
  }

  startDownload() async {
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path = '${appDocDir!.path}/${widget.title}.epub';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio
          .download(
        widget.downloadUrlImage,
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {},
      )
          .whenComplete(() {
        setState(() {
          filePath = path;
        });
      });
    } else {
      setState(() {
        filePath = path;
      });
    }
  }

  /// ANDROID VERSION
  Future<void> fetchAndroidVersion() async {
    final PermissionStatus status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      await startDownload();
    } else {
      await Permission.storage.request();
    }
  }

  download() async {
    if (Platform.isIOS) {
      final PermissionStatus status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
        await startDownload();
      } else {
        await Permission.storage.request();
      }
    } else if (Platform.isAndroid) {
      await fetchAndroidVersion();
    } else {
      PlatformException(code: '500');
    }
  }

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
                  style:
                      const TextStyle(color: Color(0xff7b2cbf), fontSize: 16),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.author,
                  style: const TextStyle(
                    color: Color(0xffd4d4d4),
                  ),
                ), const SizedBox(height:3),
                ElevatedButton(onPressed: () {
                  log("=====filePath======${filePath.toString()}");
                      if (filePath == "") {
                        download();
                      } else {
                        download();
                        openBook();
                        setState(() {
                          filePath == '';
                        });
                      }
                }, child: const Text('Abrir livro')),
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

  openBook() {
    VocsyEpub.setConfig(
      themeColor: Theme.of(context).primaryColor,
      identifier: "iosBook",
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      allowSharing: true,
      enableTts: true,
      nightMode: true,
    );

    // get current locator
    VocsyEpub.locatorStream.listen((locator) {
      log('LOCATOR: $locator');
    });

    VocsyEpub.open(
      filePath,
      lastLocation: EpubLocator.fromJson({
        "bookId": "2239",
        "href": "/OEBPS/ch06.xhtml",
        "created": 1539934158390,
        "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
      }),
    );
  }
}
