import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salamander_app/data/repositories/wallet/exceptions/wallet_repository_exception.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';

class WalletRepository {
  WalletRepository();

  final CollectionReference _usersCollectionRef =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _walletsCollectionRef = FirebaseFirestore.instance
      .collection('wallets')
      .withConverter<WalletEntity>(
        fromFirestore: (snapshot, _) => WalletEntity.fromSnapshot(snapshot),
        toFirestore: (wallet, _) => wallet.toJson(),
      );

  Wallet? _currentWallet;

  Stream<Wallet>? get wallet {
    if (_currentWallet == null) {
      return null;
    }
    return _walletsCollectionRef
        .doc(_currentWallet!.id)
        .snapshots()
        .map((snapshot) {
      return Wallet.fromEntity(WalletEntity.fromSnapshot(snapshot));
    });
  }

  Future<Wallet?> get currentWallet async {
    if (_currentWallet == null) {
      var user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return null;
      }

      var userRef = await _usersCollectionRef.doc(user.uid).get();
      if (userRef.exists) {
        var walletId = await userRef.get('active_wallet_id') as String;

        var snap = await _walletsCollectionRef.doc(walletId).get();
        _currentWallet = Wallet.fromEntity(WalletEntity.fromSnapshot(snap));
        return _currentWallet;
      }
    } else {
      return _currentWallet;
    }
    return null;
  }

  Future<Wallet?> createWallet() async {
    var createWalletCallable =
        FirebaseFunctions.instanceFor(region: 'southamerica-east1')
            .httpsCallable('createWallet');

    try {
      var result = await createWalletCallable();
      var resMap = result.data as Map<String, dynamic>;
      var walletId = resMap['wallet_id'] as String;
      var snap = await _walletsCollectionRef.doc(walletId).get();
      _currentWallet = Wallet.fromEntity(WalletEntity.fromSnapshot(snap));
      return _currentWallet;
    } on FirebaseFunctionsException catch (e) {
      throw CreateWalletFailure.fromCode(e.code);
    } catch (e) {
      throw const CreateWalletFailure();
    }
  }
}
