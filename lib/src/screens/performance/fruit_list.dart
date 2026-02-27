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
    final sortedFruits = List<Fruit>.from(fruitData)
      ..sort((a, b) {
        // Simulate complex comparison
        return a.title.length.compareTo(b.title.length) *
                a.title.codeUnits.fold<int>(0, (p, c) => p + c) -
            b.title.codeUnits.fold<int>(0, (p, c) => p + c);
      });

    return ListView.builder(
      itemCount: sortedFruits.length * 100, // Inflate list size
      // PITFALL: Removed itemExtent to force layout of every item during scroll
      // itemExtent: _imageSize + defaultSpacing,
      itemBuilder: (context, index) {
        final fruit = sortedFruits[index % sortedFruits.length];

        // PITFALL: Unnecessary nesting
        return Padding(
          padding: const EdgeInsets.all(densePadding),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            // PITFALL: Opacity triggers saveLayer which is expensive
            child: Opacity(
              opacity: 0.99,
              child: ListTile(
                onTap: () => Navigator.of(
                  context,
                ).pushNamed(AppRoute.performanceDetails.path, arguments: fruit),
                leading:
                    // PITFALL: ClipRRect with anti-aliasing is expensive if overused
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset(
                        fruit.imageUrl,
                        width: _imageSize,
                        height: _imageSize,
                        // PITFALL: Removed cacheWidth/cacheHeight
                        // cacheWidth: 150,
                        // cacheHeight: 150,
                        fit: BoxFit.cover,
                        // PITFALL: High filter quality is slower
                        filterQuality: FilterQuality.high,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: _imageSize,
                            height: _imageSize,
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                title: Text(fruit.title),
                subtitle: Text(
                  'Length: ${fruit.title.length} characters\nHash: ${fruit.hashCode}',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
