import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';

part 'receive_coins_state.dart';

class ReceiveCoinsCubit extends Cubit<ReceiveCoinsState> {
  ReceiveCoinsCubit({required WalletRepository walletRepository})
      : _walletRepository = walletRepository,
        super(const ReceiveCoinsState(address: 'address'));

  final WalletRepository _walletRepository;
}
