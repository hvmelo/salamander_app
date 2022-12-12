part of 'amount_input_cubit.dart';

enum AmountInputStatus {
  initial,
  editingNotReady,
  editingReady,
  failure,
}

class AmountInputState extends Equatable {
  const AmountInputState._({
    required this.amount,
    this.balance,
    this.totalFeeByPriority,
    this.txFeeByPriority,
    this.selectedPriority = FeePriority.standard,
    this.status = AmountInputStatus.initial,
    this.errorMessage,
  });

  AmountInputState.initial() : this._(amount: 0);

  final AmountInputStatus status;
  final int amount;
  final int? balance;
  final Map<FeePriority, int>? txFeeByPriority;
  final Map<FeePriority, int>? totalFeeByPriority;
  final FeePriority selectedPriority;
  final String? errorMessage;

  AmountInputState copyWith(
      {AmountInputStatus? status,
      int? amount,
      int? balance,
      Map<FeePriority, int>? txFeeByPriority,
      Map<FeePriority, int>? totalFeeByPriority,
      FeePriority? selectedPriority,
      String? errorMessage}) {
    return AmountInputState._(
        status: status ?? this.status,
        amount: amount ?? this.amount,
        balance: balance ?? this.balance,
        txFeeByPriority: txFeeByPriority ?? this.txFeeByPriority,
        totalFeeByPriority: totalFeeByPriority ?? this.totalFeeByPriority,
        selectedPriority: selectedPriority ?? this.selectedPriority,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [
        status,
        amount,
        balance,
        txFeeByPriority,
        totalFeeByPriority,
        selectedPriority,
        errorMessage
      ];
}
