import 'dart:convert';

class Painting {
  const Painting({
    required this.title,
    required this.imageUrl,
  });

  factory Painting.fromJson(Map<String, dynamic> json) {
    return Painting(
      title: json['title'] as String,
      imageUrl: json['image_url'] as String,
    );
  }

  static List<Painting> parsePaintingsJson(String jsonStr) {
    final json = jsonDecode(jsonStr) as List;
    return json.map((item) => Painting.fromJson(item)).toList();
  }

  static List<Painting> parsePaintingsJsonWithJank(String jsonStr) {
    final json = jsonDecode(jsonStr) as List;
    return json.map((item) => Painting.fromJson(item)).toList();
  }

  final String title;
  final String imageUrl;
}