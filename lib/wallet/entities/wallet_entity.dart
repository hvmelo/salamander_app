import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  const WalletEntity({
    required this.balance,
  });

  final double balance;

  @override
  List<Object?> get props => [balance];
}
