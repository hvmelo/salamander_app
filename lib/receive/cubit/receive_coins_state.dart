part of 'receive_coins_cubit.dart';

class ReceiveCoinsState extends Equatable {
  const ReceiveCoinsState({required this.address});

  final String address;

  @override
  List<Object> get props => [address];
}
