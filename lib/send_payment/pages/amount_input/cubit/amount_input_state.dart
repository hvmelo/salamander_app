part of 'amount_input_cubit.dart';

enum AmountInputStatus { initial, editing, failure, success }

class AmountInputState extends Equatable {
  const AmountInputState._({
    required this.amount,
    this.balance,
    this.status = AmountInputStatus.initial,
    this.errorMessage,
  });

  const AmountInputState.initial() : this._(amount: 0);

  final AmountInputStatus status;
  final num amount;
  final num? balance;
  final String? errorMessage;

  AmountInputState copyWith(
      {AmountInputStatus? status,
      num? amount,
      num? balance,
      String? errorMessage}) {
    return AmountInputState._(
        status: status ?? this.status,
        amount: amount ?? this.amount,
        balance: balance ?? this.balance,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [status, amount, balance, errorMessage];
}
