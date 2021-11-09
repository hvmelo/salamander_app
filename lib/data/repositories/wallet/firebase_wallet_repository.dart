import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';

class FirebaseWalletRepository implements WalletRepository {
  @override
  Stream<Wallet> walletStream() {
    // TODO: implement walletStream
    throw UnimplementedError();
  }

  @override
  Future<void> createWallet() async {
    //   try {
    //     var uid = FirebaseAuth.instance.currentUser?.uid;
    //     DocumentReference documentReference =
    //         FirebaseFirestore.instance.collection('wallets').doc(uid);
    //     FirebaseFirestore.instance.runTransaction((transaction) async {
    //       var snapshot = await transaction.get(documentReference);
    //       var data = snapshot.data() as Map<String, dynamic>;
    //       if (!snapshot.exists) {
    //         documentReference.set({"Amount": value});
    //         return true;
    //       }
    //       double newAmount = data['Amount'] + value;
    //       transaction.update(documentReference, {'Amount': newAmount});
    //       return true;
    //     });
    //   } catch (e) {
    //     return false;
    //   }
    // }
  }
}
