// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BookModel {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String downloadUrl;
  final bool isFavorite;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.downloadUrl,
    required this.isFavorite,
  });

  BookModel copyWith({
    int? id,
    String? title,
    String? author,
    String? coverUrl,
    String? downloadUrl,
    bool? isFavorite,
  }) {
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverUrl: coverUrl ?? this.coverUrl,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'coverUrl': coverUrl,
      'downloadUrl': downloadUrl,
      'isFavorite': isFavorite,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'] as int,
      title: map['title'] as String,
      author: map['author'] as String,
      coverUrl: map['coverUrl'] as String,
      downloadUrl: map['downloadUrl'] as String,
      isFavorite: map['isFavorite'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookModel(id: $id, title: $title, author: $author, coverUrl: $coverUrl, downloadUrl: $downloadUrl, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(covariant BookModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.author == author &&
        other.coverUrl == coverUrl &&
        other.downloadUrl == downloadUrl &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        author.hashCode ^
        coverUrl.hashCode ^
        downloadUrl.hashCode ^
        isFavorite.hashCode;
  }
}
