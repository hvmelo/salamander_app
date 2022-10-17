import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salamander_app/constants.dart' as constants;
import 'package:salamander_app/data/repositories/transaction_fees_repository.dart';

class TransactionFeesRepository {
  TransactionFeesRepository();

  // final CollectionReference _feesCollectionRef = FirebaseFirestore.instance
  //     .collection('fees')
  //     .withConverter<WalletEntity>(
  //       fromFirestore: (snapshot, _) => WalletEntity.fromSnapshot(snapshot),
  //       toFirestore: (wallet, _) => wallet.toJson(),
  //     );

  final CollectionReference _feesCollectionRef =
      FirebaseFirestore.instance.collection(constants.FEES_COLLECTION_NAME);

  Future<OnChainTxFees?> get onChainTxFees async {
    var snap = await _feesCollectionRef
        .doc(constants.ON_CHAIN_TXS_FEES_DOC_NAME)
        .get();

    if (snap.exists) {
      return OnChainTxFees.fromEntity(OnChainTxFeesEntity.fromSnapshot(snap));
    }

    return null;
  }
}
