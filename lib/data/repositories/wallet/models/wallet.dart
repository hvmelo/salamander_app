import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:salamander_app/data/repositories/wallet/entities/wallet_entity.dart';

@immutable
class Wallet extends Equatable {
  const Wallet(
      {required this.ownerId,
      this.balance,
      this.activeAddress,
      this.lastUpdated,
      this.created,
      this.id});

  final String ownerId;
  final String? id;
  final Map? balance;
  final String? activeAddress;
  final DateTime? lastUpdated;
  final DateTime? created;

  /// Empty user which represents an unauthenticated user.
  static const empty = Wallet(ownerId: '');

  Wallet copyWith(
      {String? ownerId,
      Map? balance,
      String? activeAddress,
      DateTime? lastUpdated,
      DateTime? created,
      String? id}) {
    return Wallet(
      ownerId: ownerId ?? this.ownerId,
      balance: balance ?? this.balance,
      activeAddress: activeAddress ?? this.activeAddress,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      created: lastUpdated ?? this.lastUpdated,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props =>
      [ownerId, id, balance, activeAddress, lastUpdated, created];

  @override
  String toString() {
    return '''
        Wallet {owner id: $ownerId, 
        settled balance: ${balance != null ? balance!['total_settled'] : 0},
        active address: ${activeAddress ?? ''}, 
        id: $id, 
        created: $created}, 
        last updated: $lastUpdated}
    ''';
  }

  Map<String, Object> createNewBalance() {
    return {
      'total_settled': 0,
      'incoming': {
        'confirmed': 0,
        'unconfirmed': 0,
      },
      'outgoing': {
        'confirmed': 0,
        'unconfirmed': 0,
      }
    };
  }

  static Wallet fromEntity(WalletEntity entity) {
    return Wallet(
      ownerId: entity.ownerId,
      balance: entity.balance,
      activeAddress: entity.activeAddress,
      lastUpdated: entity.lastUpdated.toDate(),
      created: entity.created.toDate(),
      id: entity.id,
    );
  }
}
