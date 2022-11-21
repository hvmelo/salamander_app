part of 'on_chain_payment_confirmation_cubit.dart';

enum OnChainPaymentConfirmationStatus {
  initial,
  valueChanged,
  readyForPayment,
  failure,
  paymentSuccess,
  paymentFailure,
}

class OnChainPaymentConfirmationState extends Equatable {
  const OnChainPaymentConfirmationState._({
    required this.address,
    required this.amountInSats,
    required this.selectedPriority,
    required this.contractedTxFee,
    required this.contractedTotalFee,
    this.status = OnChainPaymentConfirmationStatus.initial,
    this.errorMessage,
    this.currentBalance,
  });

  final BitcoinAddress address;
  final int amountInSats;
  final FeePriority selectedPriority;
  final int contractedTxFee;
  final int contractedTotalFee;
  final OnChainPaymentConfirmationStatus status;
  final String? errorMessage;
  final int? currentBalance;

  OnChainPaymentConfirmationState copyWith(
      {BitcoinAddress? address,
      int? amountInSats,
      FeePriority? selectedPriority,
      int? contractedTxFee,
      int? contractedTotalFee,
      OnChainPaymentConfirmationStatus? status,
      String? errorMessage,
      int? currentBalance}) {
    return OnChainPaymentConfirmationState._(
        address: address ?? this.address,
        amountInSats: amountInSats ?? this.amountInSats,
        selectedPriority: selectedPriority ?? this.selectedPriority,
        contractedTxFee: contractedTxFee ?? this.contractedTxFee,
        contractedTotalFee: contractedTotalFee ?? this.contractedTotalFee,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        currentBalance: currentBalance ?? this.currentBalance);
  }

  @override
  List<Object?> get props => [
        address,
        amountInSats,
        selectedPriority,
        status,
        errorMessage,
        currentBalance
      ];
}
