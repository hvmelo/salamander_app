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

  final Map<String, num> totalTxFeeByPriority;
  final Map<String, num> txFeeByPriority;
  final num currentMargin;
  final num currentServiceFee;
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
      totalTxFeeByPriority: entity.totalTxFeeByPriority as Map<String, num>,
      txFeeByPriority: entity.txFeeByPriority as Map<String, num>,
      currentMargin: entity.currentMargin,
      currentServiceFee: entity.currentServiceFee,
      lastUpdated: entity.lastUpdated,
    );
  }
}
