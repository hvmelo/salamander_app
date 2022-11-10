import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salamander_app/constants.dart' as constants;
import 'package:salamander_app/data/repositories/transaction_fees_repository.dart';

class TransactionFeesRepository {
  TransactionFeesRepository();

  final CollectionReference _feesCollectionRef =
      FirebaseFirestore.instance.collection(constants.FEES_COLLECTION_NAME);

  Stream<OnChainTxFees>? get onChainTxFees {
    return _feesCollectionRef
        .doc(constants.ON_CHAIN_TXS_FEES_DOC_NAME)
        .snapshots()
        .map((snapshot) {
      return OnChainTxFees.fromEntity(
          OnChainTxFeesEntity.fromSnapshot(snapshot));
    });
  }
}
