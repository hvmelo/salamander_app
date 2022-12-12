import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:salamander_app/data/repositories/transaction_fees/entities/on_chain_tx_fees_entity.dart';

enum FeePriority {
  low('Low', 0, 10),
  standard('Standard', 1, 30),
  high('High', 2, 60);

  const FeePriority(this.name, this.value, this.confirmationTime);
  factory FeePriority.fromValue(double value) {
    return values.firstWhere((e) => e.value == value, orElse: () => low);
  }

  final String name;
  final double value;
  final int confirmationTime;
}

class OnChainTxFees extends Equatable {
  const OnChainTxFees(
      {required this.totalTxFeeByPriority,
      required this.txFeeByPriority,
      required this.currentMargin,
      required this.currentServiceFee,
      required this.lastUpdated});

  final Map<FeePriority, int> totalTxFeeByPriority;
  final Map<FeePriority, int> txFeeByPriority;
  final int currentMargin;
  final int currentServiceFee;
  final Timestamp lastUpdated;

  @override
  String toString() {
    return '''
        OnChain Tx Fee {total tx fee: low ${totalTxFeeByPriority['low']} 
        standard ${totalTxFeeByPriority['standard']} high ${totalTxFeeByPriority['high']},
        tx fee: low ${txFeeByPriority['low']} 
        standard ${txFeeByPriority['standard']} high ${txFeeByPriority['high']},
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
    var txFeeByPriority =
        entity.txFeeByPriority.cast<String, int>().map<FeePriority, int>(
      (key, value) {
        var priority = key == 'high'
            ? FeePriority.high
            : (key == 'standard' ? FeePriority.standard : FeePriority.low);
        return MapEntry(priority, value);
      },
    );

    var totalFeeByPriority =
        entity.totalTxFeeByPriority.cast<String, int>().map<FeePriority, int>(
      (key, value) {
        var priority = key == 'high'
            ? FeePriority.high
            : (key == 'standard' ? FeePriority.standard : FeePriority.low);
        return MapEntry(priority, value);
      },
    );

    return OnChainTxFees(
      totalTxFeeByPriority: totalFeeByPriority,
      txFeeByPriority: txFeeByPriority,
      currentMargin: entity.currentMargin as int,
      currentServiceFee: entity.currentServiceFee as int,
      lastUpdated: entity.lastUpdated,
    );
  }
}
