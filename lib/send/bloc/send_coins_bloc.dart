import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'send_coins_event.dart';
part 'send_coins_state.dart';

class SendCoinsBloc extends Bloc<SendCoinsEvent, SendCoinsState> {
  SendCoinsBloc() : super(SendCoinsInitial()) {
    on<Init>(_onInit);
    on<ManualEntryRequested>(_onManualEntryRequested);
    on<QRCodeRead>(_onQRCodeRead);
  }

  void _onInit(Init event, Emitter<SendCoinsState> emit) {}

  void _onManualEntryRequested(
      ManualEntryRequested event, Emitter<SendCoinsState> emit) {}

  void _onQRCodeRead(QRCodeRead event, Emitter<SendCoinsState> emit) {}
}
