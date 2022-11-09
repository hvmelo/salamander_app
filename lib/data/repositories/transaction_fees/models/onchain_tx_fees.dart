import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:salamander_app/data/repositories/transaction_fees/entities/on_chain_tx_fees_entity.dart';

class OnChainTxFees extends Equatable {
  const OnChainTxFees(
      {required this.totalTxFeeByPriority,
      required this.txFeeByPriority,
      required this.currentMargin,
      required this.currentServiceFee,
      required this.lastUpdated});

  final Map<String, int> totalTxFeeByPriority;
  final Map<String, int> txFeeByPriority;
  final int currentMargin;
  final int currentServiceFee;
  final Timestamp lastUpdated;

  @override
  String toString() {
    return '''
        OnChain Tx Fee {total tx fee: low ${totalTxFeeByPriority['low']} 
        medium ${totalTxFeeByPriority['medium']} high ${totalTxFeeByPriority['high']},
        tx fee: low ${txFeeByPriority['low']} 
        medium ${txFeeByPriority['medium']} high ${txFeeByPriority['high']},
        current margin: $currentMargin, current service fee: $currentServiceFee,
        last updated: $lastUpdated}
    ''';
  }

  @override
  List<Object?> get props => [
        totalTxFeeByPriority,
        txFeeByPriority,
        currentMargin,
        currentServiceFee,
        lastUpdated,
      ];

  static OnChainTxFees fromEntity(OnChainTxFeesEntity entity) {
    return OnChainTxFees(
      totalTxFeeByPriority: entity.totalTxFeeByPriority.cast<String, int>(),
      txFeeByPriority: entity.txFeeByPriority.cast<String, int>(),
      currentMargin: entity.currentMargin as int,
      currentServiceFee: entity.currentServiceFee as int,
      lastUpdated: entity.lastUpdated,
    );
  }
}
