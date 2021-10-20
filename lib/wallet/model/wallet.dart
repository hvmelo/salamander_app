import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:salamander_app/wallet/entities/wallet_entity.dart';

@immutable
class Wallet extends Equatable {
  const Wallet({
    this.balance = 0,
  });

  final double balance;

  @override
  List<Object> get props => [balance];

  @override
  String toString() {
    return 'Wallet{balance: $balance}';
  }

  WalletEntity toEntity() {
    return WalletEntity(
      balance: balance,
    );
  }

  static Wallet fromEntity(Wallet entity) {
    return Wallet(
      balance: entity.balance,
    );
  }

  static const empty = Wallet();
}
