import 'dart:convert';

class Fruit {
  const Fruit({required this.title, required this.imageUrl});

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
      title: json['title'] as String,
      imageUrl: json['image_path'] as String,
    );
  }

  static List<Fruit> parseJson(String jsonStr) {
    final json = jsonDecode(jsonStr) as List;
    return json.map((item) => Fruit.fromJson(item)).toList();
  }

  final String title;
  final String imageUrl;
}

const fruitDataStr = '''
[
  {
    "title": "Apple",
    "image_path": "assets/images/apple.jpg"
  },
  {
    "title": "Artichoke",
    "image_path": "assets/images/artichoke.jpg"
  },
  {
    "title": "Asparagus",
    "image_path": "assets/images/asparagus.jpg"
  },
  {
    "title": "Avocado",
    "image_path": "assets/images/avocado.jpg"
  },
  {
    "title": "Blackberry",
    "image_path": "assets/images/blackberry.jpg"
  },
  {
    "title": "Cantaloupe",
    "image_path": "assets/images/cantaloupe.jpg"
  },
  {
    "title": "Cauliflower",
    "image_path": "assets/images/cauliflower.jpg"
  },
  {
    "title": "Endive",
    "image_path": "assets/images/endive.jpg"
  },
  {
    "title": "Fig",
    "image_path": "assets/images/fig.jpg"
  },
  {
    "title": "Grape",
    "image_path": "assets/images/grape.jpg"
  },
  {
    "title": "Green Bell Pepper",
    "image_path": "assets/images/green_bell_pepper.jpg"
  },
  {
    "title": "Habanero",
    "image_path": "assets/images/habanero.jpg"
  },
  {
    "title": "Kale",
    "image_path": "assets/images/kale.jpg"
  },
  {
    "title": "Kiwi",
    "image_path": "assets/images/kiwi.jpg"
  },
  {
    "title": "Lemon",
    "image_path": "assets/images/lemon.jpg"
  },
  {
    "title": "Lime",
    "image_path": "assets/images/lime.jpg"
  },
  {
    "title": "Mango",
    "image_path": "assets/images/mango.jpg"
  },
  {
    "title": "Mushroom",
    "image_path": "assets/images/mushroom.jpg"
  },
  {
    "title": "Nectarine",
    "image_path": "assets/images/nectarine.jpg"
  },
  {
    "title": "Persimmon",
    "image_path": "assets/images/persimmon.jpg"
  },
  {
    "title": "Plum",
    "image_path": "assets/images/plum.jpg"
  },
  {
    "title": "Potato",
    "image_path": "assets/images/potato.jpg"
  },
  {
    "title": "Radicchio",
    "image_path": "assets/images/radicchio.jpg"
  },
  {
    "title": "Radish",
    "image_path": "assets/images/radish.jpg"
  },
  {
    "title": "Squash",
    "image_path": "assets/images/squash.jpg"
  },
  {
    "title": "Strawberry",
    "image_path": "assets/images/strawberry.jpg"
  },
  {
    "title": "Tangelo",
    "image_path": "assets/images/tangelo.jpg"
  },
  {
    "title": "Tomato",
    "image_path": "assets/images/tomato.jpg"
  },
  {
    "title": "Watermelon",
    "image_path": "assets/images/watermelon.jpg"
  },
  {
    "title": "Orange Bell Pepper",
    "image_path": "assets/images/orange_bell_pepper.jpg"
  }
]
''';
