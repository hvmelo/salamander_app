// ignore_for_file: lines_longer_than_80_chars

import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send_payment/pages/payment_confirmation/on_chain/cubit/on_chain_payment_confirmation_cubit.dart';
import 'package:salamander_app/send_payment/send_payment.dart';

class OnChainPaymentConfirmationView extends StatelessWidget {
  const OnChainPaymentConfirmationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnChainPaymentConfirmationCubit,
        OnChainPaymentConfirmationState>(
      listener: (context, state) {
        switch (state.status) {
          case OnChainPaymentConfirmationStatus.paymentSuccess:
            // context.flow<PaymentFlowData>().update((s) => s.copyWith(
            //       amountInSats: state.amount,
            //       selectedFeePriority: state.selectedPriority,
            //       contractedTotalFee:
            //           state.totalFeeByPriority![state.selectedPriority],
            //       contractedTxFee:
            //           state.txFeeByPriority![state.selectedPriority],
            //     ));
            break;
          case OnChainPaymentConfirmationStatus.valueChanged:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..clearSnackBars()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Unknown error'),
                ),
              );
            context.flow<PaymentFlowData>().update(
                  (state) =>
                      PaymentFlowData(useQRCode: false, address: state.address),
                );
            break;
          case OnChainPaymentConfirmationStatus.paymentFailure:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..clearSnackBars()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Unknown error'),
                ),
              );
            break;
          default:
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            automaticallyImplyLeading: true,
            title: Column(
              children: [
                const Text('BALANCE',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    )),
                BlocBuilder<OnChainPaymentConfirmationCubit,
                    OnChainPaymentConfirmationState>(
                  builder: (context, state) {
                    return Text(
                      '${state.currentBalance != null ? state.currentBalance.toString() : '---'} sats',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 142, 195, 238),
                      ),
                    );
                  },
                ),
              ],
            ),
            leading: GestureDetector(
              onTap: () => context.flow<PaymentFlowData>().update(
                    (state) => PaymentFlowData(
                        useQRCode: false, address: state.address),
                  ),
              child: const Icon(Icons.arrow_back_ios),
            ),
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () => context.flow<PaymentFlowData>().complete(),
                    child: const Icon(Icons.close),
                  )),
            ]),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<OnChainPaymentConfirmationCubit,
                    OnChainPaymentConfirmationState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Please review your payment details',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Destination BTC address:',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${state.address.address}',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 142, 195, 238),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'The recipient will receive:',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${state.amountInSats} sats',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 142, 195, 238),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Fees applied:',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${state.contractedTotalFee} sats',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 142, 195, 238),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Priority you chose:',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${state.selectedPriority.name} (confirmation in ~ ${state.selectedPriority.confirmationTime} minutes)',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 142, 195, 238),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Expanded(child: Container()),
                                const Text(
                                  'Amount to be deducted from your account:',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text:
                                        '${state.amountInSats + state.contractedTotalFee}',
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 231, 241, 123),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                    children: [
                                      const TextSpan(
                                        text: ' sats',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 231, 241, 123),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(child: Container()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 4,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: BlocBuilder<OnChainPaymentConfirmationCubit,
                            OnChainPaymentConfirmationState>(
                          builder: (context, state) {
                            return ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.check,
                                size: 20,
                                textDirection: TextDirection.ltr,
                              ),
                              label: const Text(
                                'CONFIRM PAYMENT',
                                style: TextStyle(fontSize: 14),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
