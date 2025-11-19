import 'package:flutter/material.dart';

import '../scaffold/router.dart';
import 'router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static const _drawerWidth = 200.0;
  static const _topSpacing = 60.0;

  @override
  Widget build(BuildContext context) {
    final currentPath = ModalRoute.of(context)?.settings.name ?? AppRouter.home;
    return Drawer(
      width: _drawerWidth,
      child: ListView(
        padding: const EdgeInsets.only(top: _topSpacing),
        children: <Widget>[
          _DrawerItem(
            iconAsset: 'assets/icons/devtools.png',
            title: 'Home',
            path: AppRouter.home,
            currentPath: currentPath,
          ),
          _DrawerItem(
            iconAsset: 'assets/icons/inspector.png',
            title: 'Inspector',
            path: AppRouter.inspector,
            currentPath: currentPath,
          ),
          _DrawerItem(
            iconAsset: 'assets/icons/performance.png',
            title: 'Performance',
            path: AppRouter.performance,
            currentPath: currentPath,
          ),
          _DrawerItem(
            iconAsset: 'assets/icons/network.png',
            title: 'Network',
            path: AppRouter.network,
            currentPath: currentPath,
          ),
          _DrawerItem(
            iconAsset: 'assets/icons/memory.png',
            title: 'Memory',
            path: AppRouter.memory,
            currentPath: currentPath,
          ),
          _DrawerItem(
            iconAsset: 'assets/icons/cpu_profiler.png',
            title: 'CPU Profiler',
            path: AppRouter.cpuProfiler,
            currentPath: currentPath,
          ),
          _DrawerItem(
            iconAsset: 'assets/icons/debugger.png',
            title: 'Debugger',
            path: AppRouter.debugger,
            currentPath: currentPath,
          ),
          _DrawerItem(
            iconAsset: 'assets/icons/logging.png',
            title: 'Logging',
            path: AppRouter.logging,
            currentPath: currentPath,
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.title,
    required this.iconAsset,
    required this.path,
    required this.currentPath,
  });

  final String iconAsset;
  final String title;
  final String path;
  final String currentPath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = currentPath == path;
    final color = isSelected
        ? theme.colorScheme.primary
        : theme.textTheme.bodyLarge?.color;

    return ListTile(
      leading: AssetImageIcon(asset: iconAsset, color: color),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: color,
        ),
      ),
      selected: isSelected,
      onTap: () {
        // Close the drawer.
        Navigator.pop(context);
        // Navigate to the new screen, but only if it's not the current one.
        if (!isSelected) {
          Navigator.pushReplacementNamed(context, path);
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
