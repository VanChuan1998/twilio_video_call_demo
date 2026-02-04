import 'package:equatable/equatable.dart';

/// Điểm đến logic cho từng item trong drawer.
enum DrawerDestination {
  home,
  profile,
  appointments,
  calendar,
  contact,
  terms,
  privacy,
}

/// Entity biểu diễn một item trong menu drawer.
class MenuItemEntity extends Equatable {
  final String id;
  final String title;
  final DrawerDestination destination;

  const MenuItemEntity({
    required this.id,
    required this.title,
    required this.destination,
  });

  @override
  List<Object?> get props => [id, title, destination];
}

