import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  const WalletEntity(this.balance, this.lastUpdated, this.id);

  final double balance;
  final String id;
  final DateTime lastUpdated;

  Map<String, Object> toJson() {
    return {
      'balance': balance,
      'lastUpdated': lastUpdated,
      'id': id,
    };
  }

  @override
  List<Object?> get props => [id, balance, lastUpdated];

  static WalletEntity fromJson(Map<String, Object> json) {
    return WalletEntity(
      json['balance'] as double,
      json['lastUpdated'] as DateTime,
      json['id'] as String,
    );
  }

  static WalletEntity fromSnapshot(DocumentSnapshot snap) {
    return WalletEntity(
      snap.get('balance') as double,
      snap.get('lastUpdated') as DateTime,
      snap.id,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'balance': balance,
      'lastUpdated': lastUpdated,
    };
  }
}
