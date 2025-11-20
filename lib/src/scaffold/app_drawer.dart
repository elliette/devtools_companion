import 'package:flutter/material.dart';

import 'router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static const _drawerWidth = 200.0;
  static const _topSpacing = 60.0;

  @override
  Widget build(BuildContext context) {
    final currentPath =
        ModalRoute.of(context)?.settings.name ?? AppRoute.home.path;
    return Drawer(
      width: _drawerWidth,
      child: ListView(
        padding: const EdgeInsets.only(top: _topSpacing),
        children: AppRoute.values
            .where((route) => route.showInAppDrawer)
            .map((route) => _DrawerItem(route: route, currentPath: currentPath))
            .toList(),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({required this.route, required this.currentPath});

  final AppRoute route;
  final String currentPath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = currentPath == route.path;
    final color = isSelected
        ? theme.colorScheme.primary
        : theme.textTheme.bodyLarge?.color;

    return ListTile(
      leading: AssetImageIcon(asset: route.iconAsset, color: color),
      title: Text(
        route.name,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: color,
        ),
      ),
      selected: isSelected,
      onTap: () async {
        Navigator.pop(context);
        if (!isSelected) {
          await Navigator.pushReplacementNamed(context, route.path);
        }
      },
    );
  }
}

/// A widget that renders an [asset] image styled as an icon.
final class AssetImageIcon extends StatelessWidget {
  const AssetImageIcon({super.key, required this.asset, this.color});

  static const _iconSize = 18.0;

  final String asset;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(asset),
      height: _iconSize,
      width: _iconSize,
      fit: BoxFit.fill,
      color: color ?? Theme.of(context).colorScheme.onSurface,
    );
  }
}
