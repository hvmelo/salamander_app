part of 'send_coins_bloc.dart';

abstract class SendCoinsState extends Equatable {
  const SendCoinsState();

  @override
  List<Object> get props => [];
}

class SendCoinsInitial extends SendCoinsState {}

class SendCoinsWrongAddress extends SendCoinsState {}
