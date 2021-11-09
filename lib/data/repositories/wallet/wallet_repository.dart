import 'package:salamander_app/data/repositories/wallet_repository.dart';

abstract class WalletRepository {
  Future<void> createWallet();

  Stream<Wallet> walletStream();
}
