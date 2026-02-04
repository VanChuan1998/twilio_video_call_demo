import 'package:flutter/material.dart';

import '../../domain/entities/menu_item_entity.dart';

/// Dữ liệu hiển thị cho header drawer.
class DrawerUserViewData {
  final String displayName;

  const DrawerUserViewData({required this.displayName});
}

/// Widget drawer chính, thuần UI.
class AppDrawer extends StatelessWidget {
  final DrawerUserViewData user;
  final List<MenuItemEntity> items;
  final String? selectedItemId;
  final VoidCallback onClose;
  final ValueChanged<MenuItemEntity> onItemSelected;
  final VoidCallback onLogout;

  const AppDrawer({
    super.key,
    required this.user,
    required this.items,
    required this.selectedItemId,
    required this.onClose,
    required this.onItemSelected,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final drawerWidth = size.width * 0.75;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: drawerWidth,
        child: SafeArea(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            child: Container(
              color: colorScheme.surface,
              child: Column(
                children: [
                  _DrawerHeaderSection(
                    user: user,
                    onClose: onClose,
                  ),
                  Expanded(
                    child: _DrawerMenuList(
                      items: items,
                      selectedItemId: selectedItemId,
                      onItemSelected: onItemSelected,
                    ),
                  ),
                  _LogoutSection(onLogout: onLogout),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerHeaderSection extends StatelessWidget {
  final DrawerUserViewData user;
  final VoidCallback onClose;

  const _DrawerHeaderSection({
    required this.user,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final name = user.displayName.trim().isEmpty ? 'User' : user.displayName;
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'U';

    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: colorScheme.primaryContainer,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: onClose,
              icon: const Icon(Icons.close),
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: colorScheme.onPrimaryContainer,
                  child: CircleAvatar(
                    radius: 36,
                    backgroundColor: colorScheme.primary,
                    child: Text(
                      initial,
                      style: textTheme.headlineSmall?.copyWith(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Hi, $name',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerMenuList extends StatelessWidget {
  final List<MenuItemEntity> items;
  final String? selectedItemId;
  final ValueChanged<MenuItemEntity> onItemSelected;

  const _DrawerMenuList({
    required this.items,
    required this.selectedItemId,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 4),
      itemBuilder: (context, index) {
        final item = items[index];
        final isSelected = item.id == selectedItemId;
        return _DrawerMenuItem(
          title: item.title,
          destination: item.destination,
          isSelected: isSelected,
          onTap: () => onItemSelected(item),
        );
      },
    );
  }
}

class _DrawerMenuItem extends StatelessWidget {
  final String title;
  final DrawerDestination destination;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrawerMenuItem({
    required this.title,
    required this.destination,
    required this.isSelected,
    required this.onTap,
  });

  IconData _iconForDestination() {
    switch (destination) {
      case DrawerDestination.home:
        return Icons.home_outlined;
      case DrawerDestination.profile:
        return Icons.person_outline;
      case DrawerDestination.appointments:
        return Icons.event_note_outlined;
      case DrawerDestination.calendar:
        return Icons.calendar_today_outlined;
      case DrawerDestination.contact:
        return Icons.mail_outline;
      case DrawerDestination.terms:
        return Icons.description_outlined;
      case DrawerDestination.privacy:
        return Icons.privacy_tip_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final backgroundColor =
        isSelected ? colorScheme.primary : colorScheme.surface;
    final iconColor =
        isSelected ? colorScheme.onPrimary : colorScheme.primary;
    final textColor =
        isSelected ? colorScheme.onPrimary : colorScheme.onSurface;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            Icon(
              _iconForDestination(),
              size: 20,
              color: iconColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  color: textColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoutSection extends StatelessWidget {
  final VoidCallback onLogout;

  const _LogoutSection({required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SafeArea(
      top: false,
      child: InkWell(
        onTap: onLogout,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          color: colorScheme.surfaceVariant,
          child: Row(
            children: [
              Icon(
                Icons.logout,
                color: colorScheme.onSurface,
              ),
              const SizedBox(width: 12),
              Text(
                'Logout',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

