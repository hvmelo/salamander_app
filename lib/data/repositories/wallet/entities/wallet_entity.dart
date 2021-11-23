import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  const WalletEntity(this.ownerId, this.balance, this.lastUpdated, this.id);

  final String ownerId;
  final double balance;
  final String id;
  final Timestamp lastUpdated;

  Map<String, Object> toJson() {
    return {
      'owner_id': ownerId,
      'balance': balance,
      'lastUpdated': lastUpdated,
      'id': id,
    };
  }

  @override
  List<Object?> get props => [ownerId, id, balance, lastUpdated];

  static WalletEntity fromJson(Map<String, dynamic> json) {
    return WalletEntity(
      json['owner']['uid'] as String,
      json['current_balance'].toDouble() as double,
      json['last_updated'] as Timestamp,
      json['id'] as String,
    );
  }

  static WalletEntity fromSnapshot(DocumentSnapshot snap) {
    return WalletEntity(
      snap.get('owner_id') as String,
      snap.get('current_balance').toDouble() as double,
      snap.get('last_updated') as Timestamp,
      snap.id,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'owner.id': ownerId,
      'current_balance': balance,
      'last_updated': lastUpdated,
    };
  }
}
