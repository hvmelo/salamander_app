part of 'amount_input_cubit.dart';

enum AmountInputStatus { initial, editing, failure, success }

class AmountInputState extends Equatable {
  const AmountInputState._({
    required this.amount,
    this.status = AmountInputStatus.initial,
    this.errorMessage,
  });

  const AmountInputState.initial() : this._(amount: 0);
  const AmountInputState.failure(String errorMessage)
      : this._(
            amount: 0,
            status: AmountInputStatus.failure,
            errorMessage: errorMessage);

  final AmountInputStatus status;
  final num amount;
  final String? errorMessage;

  AmountInputState copyWith(
      {AmountInputStatus? status, num? amount, String? errorMessage}) {
    return AmountInputState._(
        status: status ?? this.status,
        amount: amount ?? this.amount,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [status, amount, errorMessage];
}
