part of 'send_coins_bloc.dart';

abstract class SendCoinsState extends Equatable {
  SendCoinsState();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  List<Object> get props => [qrKey];
}

class SendCoinsInitial extends SendCoinsState {}

class SendCoinsWrongAddress extends SendCoinsState {}

class SendCoinsQRRead extends SendCoinsState {
  SendCoinsQRRead(this.qrResult);
  final Barcode qrResult;
}
