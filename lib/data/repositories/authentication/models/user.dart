import 'package:equatable/equatable.dart';
import 'package:salamander_app/wallet/model/wallet.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    this.wallet,
    this.name,
  });

  final String? email;

  final String id;

  final String? name;

  final Wallet? wallet;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '', email: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id, wallet, name];
}
