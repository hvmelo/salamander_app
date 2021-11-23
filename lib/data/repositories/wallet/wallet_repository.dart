import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:salamander_app/data/repositories/authentication_repository.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';

class WalletRepository {
  WalletRepository({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository {
    _userSubscription = _authenticationRepository.user.listen(_userChanged);
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;
  final CollectionReference _usersCollectionRef =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _walletsCollectionRef = FirebaseFirestore.instance
      .collection('wallets')
      .withConverter<WalletEntity>(
        fromFirestore: (snapshot, _) => WalletEntity.fromSnapshot(snapshot),
        toFirestore: (wallet, _) => wallet.toDocument(),
      );

  String? _currentWalletId;

  Future<void> _userChanged(User user) async {
    // var entities = await _walletsCollectionRef
    //     .where('owner.uid', isEqualTo: user.id)
    //     .get()
    //     .then((snapshot) => snapshot.docs);

    if (user.isEmpty) {
      _currentWalletId = null;
      return;
    }

    var userRef = await _usersCollectionRef.doc(user.id).get();
    if (!userRef.exists) {
      // No wallet was created for this user
      return;
    }

    _currentWalletId = userRef.get('current_wallet_id') as String;
    print(_currentWalletId);
  }

  Stream<Wallet> wallet() async* {
    var user = _authenticationRepository.currentUser;
    var userRef = await _usersCollectionRef.doc(user.id).get();
    if (!userRef.exists) {
      //Try again because Firebase needs some time before user creation
      await Future<void>.delayed(const Duration(seconds: 20));
      userRef = await _usersCollectionRef.doc(user.id).get();
      if (!userRef.exists) {
        // Here should throw exception
        return;
      }
    }
    var currentWalletId = userRef.get('current_wallet_id') as String;

    if (_currentWalletId == null) {}
    yield* _walletsCollectionRef
        .doc(currentWalletId)
        .snapshots()
        .map((snapshot) {
      return Wallet.fromEntity(WalletEntity.fromSnapshot(snapshot));
    });
  }

  void close() {
    _userSubscription.cancel();
  }

  //     try {
  //       DocumentReference doc = await createWalletForUser(user);
  //       var uid = FirebaseAuth.instance.currentUser?.uid;
  //       DocumentReference documentReference =
  //           FirebaseFirestore.instance.collection('wallets').doc(uid);
  //       FirebaseFirestore.instance.runTransaction((transaction) async {
  //         var snapshot = await transaction.get(documentReference);
  //         var data = snapshot.data() as Map<String, dynamic>;
  //         if (!snapshot.exists) {
  //           documentReference.set({"Amount": value});
  //           return true;
  //         }
  //         double newAmount = data['Amount'] + value;
  //         transaction.update(documentReference, {'Amount': newAmount});
  //         return true;
  //       });
  //     } catch (e) {
  //       return false;
  //     }
  //   }
  // }

  // Future<String> createWallet() async {
  //   try {
  //     var uid = FirebaseAuth.instance.currentUser?.uid;
  //     if (uid == null) {
  //       throw CreateWalletFailure();
  //     }
  //     var newWallet =
  //         Wallet(ownerId: uid, balance: 0, lastUpdated: DateTime.now());
  //     var ref = await _walletsCollection.add(newWallet.toEntity().toDocument());
  //     return ref.id;
  //   } catch (e) {
  //     throw CreateWalletFailure();
  //   }
  // }
}

//class CreateWalletFailure implements Exception {}
