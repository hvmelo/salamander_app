import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  const WalletEntity(this.id, this.ownerId, this.balance, this.activeAddress,
      this.lastUpdated, this.created);

  final String id;
  final String ownerId;
  final Map balance;
  final String activeAddress;
  final Timestamp lastUpdated;
  final Timestamp created;

  Map<String, Object> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'balance': balance,
      'active_address': activeAddress,
      'created': created,
      'lastUpdated': lastUpdated,
    };
  }

  @override
  List<Object?> get props =>
      [ownerId, id, balance, activeAddress, created, lastUpdated];

  static WalletEntity fromJson(Map<String, dynamic> json) {
    return WalletEntity(
      json['id'] as String,
      json['owner_id'] as String,
      json['balance'] as Map,
      json['active_address'] as String,
      json['last_updated'] as Timestamp,
      json['created'] as Timestamp,
    );
  }

  static WalletEntity fromSnapshot(DocumentSnapshot snap) {
    return WalletEntity(
      snap.id,
      snap.get('owner_id') as String,
      snap.get('balance') as Map,
      snap.get('active_address') as String,
      snap.get('created') as Timestamp,
      snap.get('last_updated') as Timestamp,
    );
  }
}
