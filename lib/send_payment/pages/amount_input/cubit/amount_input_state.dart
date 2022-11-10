part of 'amount_input_cubit.dart';

enum AmountInputStatus {
  initial,
  editingNotReady,
  editingReady,
  failure,
  success,
}

class AmountInputState extends Equatable {
  const AmountInputState._({
    required this.amount,
    this.balance,
    this.feeByPriority,
    this.selectedPriority = FeePriority.standard,
    this.status = AmountInputStatus.initial,
    this.errorMessage,
  });

  AmountInputState.initial() : this._(amount: 0);

  final AmountInputStatus status;
  final int amount;
  final int? balance;
  final Map<FeePriority, int>? feeByPriority;
  final FeePriority selectedPriority;
  final String? errorMessage;

  AmountInputState copyWith(
      {AmountInputStatus? status,
      int? amount,
      int? balance,
      Map<FeePriority, int>? feeByPriority,
      FeePriority? selectedPriority,
      String? errorMessage}) {
    return AmountInputState._(
        status: status ?? this.status,
        amount: amount ?? this.amount,
        balance: balance ?? this.balance,
        feeByPriority: feeByPriority ?? this.feeByPriority,
        selectedPriority: selectedPriority ?? this.selectedPriority,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props =>
      [status, amount, balance, feeByPriority, selectedPriority, errorMessage];
}
