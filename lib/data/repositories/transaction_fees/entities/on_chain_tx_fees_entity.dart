import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class OnChainTxFeesEntity extends Equatable {
  const OnChainTxFeesEntity(this.totalTxFeeByPriority, this.txFeeByPriority,
      this.currentMargin, this.currentServiceFee, this.lastUpdated);

  final Map totalTxFeeByPriority;
  final Map txFeeByPriority;
  final num currentMargin;
  final num currentServiceFee;
  final Timestamp lastUpdated;

  Map<String, Object> toJson() {
    return {
      'totalTxFeeByPriority': totalTxFeeByPriority,
      'txFeeByPriority': txFeeByPriority,
      'currentMargin': currentMargin,
      'currentServiceFee': currentServiceFee,
      'lastUpdated': lastUpdated,
    };
  }

  @override
  List<Object?> get props => [
        totalTxFeeByPriority,
        txFeeByPriority,
        currentMargin,
        currentServiceFee,
        lastUpdated
      ];

  static OnChainTxFeesEntity fromJson(Map<String, dynamic> json) {
    return OnChainTxFeesEntity(
      json['totalTxFeeByPriority'] as Map,
      json['txFeeByPriority'] as Map,
      json['currentMargin'] as num,
      json['currentServiceFee'] as num,
      json['lastUpdated'] as Timestamp,
    );
  }

  static OnChainTxFeesEntity fromSnapshot(DocumentSnapshot snap) {
    return OnChainTxFeesEntity(
      snap.get('total_tx_fee_by_priority') as Map,
      snap.get('tx_fee_by_priority') as Map,
      snap.get('current_margin') as num,
      snap.get('current_service_fee') as num,
      snap.get('last_updated') as Timestamp,
    );
  }
}
