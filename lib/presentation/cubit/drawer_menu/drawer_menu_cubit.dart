import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/menu_item_entity.dart';
import 'drawer_menu_state.dart';

/// Cubit quản lý trạng thái menu drawer (open/close, selected item).
class DrawerMenuCubit extends Cubit<DrawerMenuState> {
  DrawerMenuCubit() : super(DrawerMenuState.initial(_buildDefaultItems()));

  static List<MenuItemEntity> _buildDefaultItems() {
    return const [
      MenuItemEntity(
        id: 'home',
        title: 'Home',
        destination: DrawerDestination.home,
      ),
      MenuItemEntity(
        id: 'profile',
        title: 'Profile',
        destination: DrawerDestination.profile,
      ),
      MenuItemEntity(
        id: 'appointments',
        title: 'My Appointments',
        destination: DrawerDestination.appointments,
      ),
      MenuItemEntity(
        id: 'calendar',
        title: 'Calendar',
        destination: DrawerDestination.calendar,
      ),
      MenuItemEntity(
        id: 'contact',
        title: 'Contact us',
        destination: DrawerDestination.contact,
      ),
      MenuItemEntity(
        id: 'terms',
        title: 'Terms & Conditions',
        destination: DrawerDestination.terms,
      ),
      MenuItemEntity(
        id: 'privacy',
        title: 'Privacy Policy',
        destination: DrawerDestination.privacy,
      ),
    ];
  }

  void toggleDrawer() => emit(state.copyWith(isOpen: !state.isOpen));

  void open() => emit(state.copyWith(isOpen: true));

  void closeDrawer() => emit(state.copyWith(isOpen: false));

  void selectItem(String id) {
    emit(
      state.copyWith(
        selectedItemId: id,
        isOpen: false,
      ),
    );
  }

  /// Lấy [MenuItemEntity] tương ứng id, phục vụ điều hướng ở UI layer.
  MenuItemEntity? findItemById(String id) {
    for (final item in state.items) {
      if (item.id == id) return item;
    }
    if (state.selectedItemId != null) {
      for (final item in state.items) {
        if (item.id == state.selectedItemId) return item;
      }
    }
    return state.items.isNotEmpty ? state.items.first : null;
  }
}

