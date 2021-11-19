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
  final CollectionReference _walletsCollectionRef = FirebaseFirestore.instance
      .collection('wallets')
      .withConverter<WalletEntity>(
        fromFirestore: (snapshot, _) => WalletEntity.fromJson(snapshot.data()!),
        toFirestore: (wallet, _) => wallet.toJson(),
      );

  String? _currentWalletId;

  Future<void> _userChanged(User user) async {
    List<QueryDocumentSnapshot<WalletEntity>> walletEntities = await _walletsCollectionRef
        .where('owner.uid', isEqualTo: user.id)
        .get()
        .then((snapshot) => snapshot.docs);
    if (snapshot.docs.isEmpty) {
      // No wallet was created for this user
      return;
    }

    var walletEntity = snapshot.docs.first.data();
      _currentWalletId = walletEntity.id;
    }
  }

  @override
  Stream<Wallet> wallet() {
    throw UnimplementedError();
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
