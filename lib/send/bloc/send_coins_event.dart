part of 'send_coins_bloc.dart';

abstract class SendCoinsEvent extends Equatable {
  const SendCoinsEvent();

  @override
  List<Object> get props => [];
}

class Init extends SendCoinsEvent {}

class ManualEntryRequested extends SendCoinsEvent {}

class QRCodeRead extends SendCoinsEvent {}
