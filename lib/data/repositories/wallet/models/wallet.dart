import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:salamander_app/data/repositories/wallet/entities/wallet_entity.dart';

@immutable
class Wallet extends Equatable {
  const Wallet(
      {required this.ownerId,
      required this.balance,
      this.lastUpdated,
      this.id});

  final String ownerId;
  final String? id;
  final double balance;
  final Timestamp? lastUpdated;

  /// Empty user which represents an unauthenticated user.
  static const empty = Wallet(ownerId: '', balance: 0);

  Wallet copyWith(
      {String? ownerId, double? balance, Timestamp? lastUpdated, String? id}) {
    return Wallet(
      ownerId: ownerId ?? this.ownerId,
      balance: balance ?? this.balance,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [ownerId, id, balance, lastUpdated];

  @override
  String toString() {
    return 'Wallet {owner id: $ownerId, balance: $balance, id: $id, last updated: $lastUpdated}';
  }

  WalletEntity toEntity() {
    return WalletEntity(
        ownerId, balance, lastUpdated ?? Timestamp.now(), id ?? '');
  }

  static Wallet fromEntity(WalletEntity entity) {
    return Wallet(
      ownerId: entity.ownerId,
      balance: entity.balance,
      lastUpdated: entity.lastUpdated,
      id: entity.id,
    );
  }
}
