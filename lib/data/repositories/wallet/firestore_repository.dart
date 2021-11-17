import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:salamander_app/data/repositories/authentication_repository.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';

class FirestoreRepository {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _walletsCollection =
      FirebaseFirestore.instance.collection('wallets');

  @override
  Stream<Wallet> walletStream() {
    // TODO: implement walletStream
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

  Future<bool> createWallet() async {
    try {
      var uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        return false;
      }
      var newWallet =
          Wallet(ownerId: uid, balance: 0, lastUpdated: DateTime.now());
      await _walletsCollection.add(newWallet.toEntity().toDocument());
      return true;
    } catch (_) {
      return false;
    }
  }
}
