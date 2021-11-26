import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:salamander_app/data/repositories/authentication_repository.dart';
import 'package:salamander_app/data/repositories/wallet/exceptions/wallet_repository_exception.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';

class WalletRepository {
  WalletRepository({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;
  final CollectionReference _usersCollectionRef =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _walletsCollectionRef = FirebaseFirestore.instance
      .collection('wallets')
      .withConverter<WalletEntity>(
        fromFirestore: (snapshot, _) => WalletEntity.fromSnapshot(snapshot),
        toFirestore: (wallet, _) => wallet.toDocument(),
      );

  Wallet? currentWallet;

  Stream<Wallet>? get wallet {
    if (currentWallet == null) {
      return null;
    }
    return _walletsCollectionRef
        .doc(currentWallet!.id)
        .snapshots()
        .map((snapshot) {
      return Wallet.fromEntity(WalletEntity.fromSnapshot(snapshot));
    });
  }

  Future<void> setupWallet() async {
    var user = _authenticationRepository.currentUser;
    var userRef = await _usersCollectionRef.doc(user.id).get();
    if (!userRef.exists) {
      await _createWallet();
      userRef = await _usersCollectionRef.doc(user.id).get();
    }

    var walletId = await userRef.get('current_wallet_id') as String;

    var snap = await _walletsCollectionRef.doc(walletId).get();
    currentWallet = Wallet.fromEntity(WalletEntity.fromSnapshot(snap));
  }

  Future<void> _createWallet() async {
    var createWalletCallable =
        FirebaseFunctions.instanceFor(region: 'southamerica-east1')
            .httpsCallable('createWallet');

    try {
      await createWalletCallable().then((value) {
        var v = value;
        print(v);
      });
    } on FirebaseFunctionsException catch (e) {
      throw CreateWalletFailure.fromCode(e.code);
    } catch (_) {
      throw const CreateWalletFailure();
    }
  }
}
