abstract class WalletRepository {
  Future<bool> startSyncing();

  void stopSyncing();

  Stream<double> get balance;
}
