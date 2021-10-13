import 'dart:async';
import 'dart:math';

import 'package:flutter_shopping_cart/data/wallet_repository.dart';

class MockWalletRepository implements WalletRepository {
  final _random = Random();
  Timer? _timer;
  bool _isRefreshing = false;
  bool isSyncing = false;
  final _controller = StreamController<double>();

  @override
  Stream<double> get balance async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield 0;
    yield* _controller.stream;
  }

  @override
  Future<bool> startSyncing() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () {
        isSyncing = true;
        _timer = Timer.periodic(
          const Duration(seconds: 10),
          _refreshBalance,
        );
      },
    );
    return isSyncing;
  }

  @override
  void stopSyncing() {
    isSyncing = false;
    _timer?.cancel();
  }

  void _refreshBalance(Timer t) async {
    if (!_isRefreshing) {
      _isRefreshing = true;
      Future.delayed(const Duration(seconds: 1), () {
        if (isSyncing) {
          _controller.add(_random.nextDouble());
        }
        _isRefreshing = false;
      });
    }
  }
}
