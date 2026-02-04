import 'package:equatable/equatable.dart';

import '../../../domain/entities/menu_item_entity.dart';

/// State cho DrawerMenuCubit.
class DrawerMenuState extends Equatable {
  final List<MenuItemEntity> items;
  final String? selectedItemId;
  final bool isOpen;

  const DrawerMenuState({
    required this.items,
    this.selectedItemId,
    this.isOpen = false,
  });

  factory DrawerMenuState.initial(List<MenuItemEntity> items) {
    final firstId = items.isNotEmpty ? items.first.id : null;
    return DrawerMenuState(
      items: items,
      selectedItemId: firstId,
      isOpen: false,
    );
  }

  DrawerMenuState copyWith({
    List<MenuItemEntity>? items,
    String? selectedItemId,
    bool? isOpen,
  }) {
    return DrawerMenuState(
      items: items ?? this.items,
      selectedItemId: selectedItemId ?? this.selectedItemId,
      isOpen: isOpen ?? this.isOpen,
    );
  }

  @override
  List<Object?> get props => [items, selectedItemId, isOpen];
}

