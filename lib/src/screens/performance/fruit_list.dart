import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../scaffold/router.dart';
import '../../shared/ui/theme.dart';
import 'data/fruits.dart';

class FruitsList extends StatefulWidget {
  const FruitsList({super.key});

  @override
  State<FruitsList> createState() => _FruitsListState();
}

class _FruitsListState extends State<FruitsList> {
  late Future<List<Fruit>> _fruitData;

  @override
  void initState() {
    super.initState();
    _fruitData = compute(Fruit.parseJson, fruitDataStr);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Fruit>>(
      future: _fruitData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.hasData) {
          return _FruitTiles(fruitData: snapshot.data!);
        }
        return const Center(child: Text('No fruits found.'));
      },
    );
  }
}

class _FruitTiles extends StatelessWidget {
  const _FruitTiles({required this.fruitData});

  final List<Fruit> fruitData;

  static const _imageSize = 60.0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: fruitData.length * 3,
      itemExtent: _imageSize + defaultSpacing,
      itemBuilder: (context, index) {
        final fruit = fruitData[index % fruitData.length];
        return Padding(
          padding: const EdgeInsets.all(densePadding),
          child: ListTile(
            onTap: () => Navigator.of(
              context,
            ).pushNamed(AppRoute.performanceDetails.path, arguments: fruit),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.asset(
                fruit.imageUrl,
                width: _imageSize,
                height: _imageSize,
                cacheWidth: 150,
                cacheHeight: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: _imageSize,
                    height: _imageSize,
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            ),
            title: Text(fruit.title),
          ),
        );
      },
    );
  }
}
