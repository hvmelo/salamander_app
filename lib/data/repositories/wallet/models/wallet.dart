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
      this.created,
      this.id});

  final String ownerId;
  final String? id;
  final double balance;
  final Timestamp? lastUpdated;
  final Timestamp? created;

  /// Empty user which represents an unauthenticated user.
  static const empty = Wallet(ownerId: '', balance: 0);

  Wallet copyWith(
      {String? ownerId,
      double? balance,
      Timestamp? lastUpdated,
      Timestamp? created,
      String? id}) {
    return Wallet(
      ownerId: ownerId ?? this.ownerId,
      balance: balance ?? this.balance,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      created: lastUpdated ?? this.lastUpdated,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [ownerId, id, balance, lastUpdated, created];

  @override
  String toString() {
    return '''
        Wallet {owner id: $ownerId, balance: $balance, id: $id, 
        created: $created}, 
        last updated: $lastUpdated}
    ''';
  }

  WalletEntity toEntity() {
    return WalletEntity(id ?? '', ownerId, balance, created ?? Timestamp.now(),
        lastUpdated ?? Timestamp.now());
  }

  static Wallet fromEntity(WalletEntity entity) {
    return Wallet(
      ownerId: entity.ownerId,
      balance: entity.balance,
      lastUpdated: entity.lastUpdated,
      created: entity.created,
      id: entity.id,
    );
  }
}
