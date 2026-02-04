import 'package:equatable/equatable.dart';

/// State lưu trữ thông tin phiên và userId trong bộ nhớ
class SessionState extends Equatable {
  final String? userId;
  final bool isSessionStarted;

  const SessionState({
    this.userId,
    this.isSessionStarted = false,
  });

  SessionState copyWith({
    String? userId,
    bool? isSessionStarted,
    bool resetUserId = false,
  }) {
    return SessionState(
      userId: resetUserId ? null : (userId ?? this.userId),
      isSessionStarted: isSessionStarted ?? this.isSessionStarted,
    );
  }

  @override
  List<Object?> get props => [userId, isSessionStarted];
}
