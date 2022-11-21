import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/data/repositories/transaction_fees/models/onchain_tx_fees.dart';
import 'package:salamander_app/data/repositories/transaction_fees/transaction_fees_repository.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';
import 'package:salamander_app/send_payment/pages/payment_confirmation/on_chain/cubit/on_chain_payment_confirmation_cubit.dart';
import 'package:salamander_app/send_payment/pages/payment_confirmation/on_chain/view/on_chain_payment_confirmation_view.dart';
import 'package:salamander_app/util/btc_input_parser.dart';

class OnChainPaymentConfirmationPage extends StatelessWidget {
  const OnChainPaymentConfirmationPage(
      {required this.bitcoinAddress,
      required this.amountInSats,
      required this.selectedFeePriority,
      required this.contractedTxFee,
      required this.contractedTotalFee});

  final BitcoinAddress bitcoinAddress;
  final int amountInSats;
  final FeePriority selectedFeePriority;
  final int contractedTxFee;
  final int contractedTotalFee;

  static MaterialPage<void> page({
    required BitcoinAddress address,
    required int amountInSats,
    required FeePriority selectedFeePriority,
    required int contractedTxFee,
    required int contractedTotalFee,
  }) {
    return MaterialPage<void>(
      child: OnChainPaymentConfirmationPage(
        bitcoinAddress: address,
        amountInSats: amountInSats,
        selectedFeePriority: selectedFeePriority,
        contractedTxFee: contractedTxFee,
        contractedTotalFee: contractedTotalFee,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnChainPaymentConfirmationCubit(
        address: bitcoinAddress,
        amountInSats: amountInSats,
        selectedPriority: selectedFeePriority,
        contractedTxFee: contractedTxFee,
        contractedTotalFee: contractedTotalFee,
        walletRepository: context.read<WalletRepository>(),
        feesRepository: context.read<TransactionFeesRepository>(),
      )..init(),
      child: const OnChainPaymentConfirmationView(),
    );
  }
}
