import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../scaffold/router.dart';
import '../../shared/ui/theme.dart';
import 'data/paintings.dart';

class PaintingsList extends StatefulWidget {
  const PaintingsList({super.key});

  @override
  State<PaintingsList> createState() => _PaintingsListState();
}

class _PaintingsListState extends State<PaintingsList> {
  late Future<List<Painting>> _paintingsData;

  @override
  void initState() {
    super.initState();
    _paintingsData = compute(Painting.parseJson, paintingsDataStr);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Painting>>(
      future: _paintingsData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.hasData) {
          return _PaintingTiles(paintingsData: snapshot.data!);
        }
        return const Center(child: Text('No paintings found.'));
      },
    );
  }
}

class _PaintingTiles extends StatelessWidget {
  const _PaintingTiles({required this.paintingsData});

  final List<Painting> paintingsData;

  static const _paintingSize = 60.0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: paintingsData.length,
      itemExtent: _paintingSize + defaultSpacing,
      itemBuilder: (context, index) {
        final painting = paintingsData[index];
        return Padding(
          padding: const EdgeInsets.all(densePadding),
          child: ListTile(
            onTap: () => Navigator.of(
              context,
            ).pushNamed(AppRoute.performanceDetails.path, arguments: painting),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.network(
                painting.imageUrl,
                width: _paintingSize,
                height: _paintingSize,
                cacheWidth: 150,
                cacheHeight: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: _paintingSize,
                    height: _paintingSize,
                    color: Theme.of(
                      context,
                    ).colorScheme.inverseSurface.withAlpha(50),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: _paintingSize,
                    height: _paintingSize,
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            ),
            title: Text(painting.title),
          ),
        );
      },
    );
  }
}
