// ignore_for_file: lines_longer_than_80_chars

import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:salamander_app/send_payment/pages/amount_input/amount_input.dart';
import 'package:salamander_app/send_payment/send_payment.dart';

class AmountInputView extends StatelessWidget {
  const AmountInputView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AmountInputCubit, AmountInputState>(
      listener: (context, state) {
        switch (state.status) {
          case AmountInputStatus.success:
            context
                .flow<PaymentFlowData>()
                .update((s) => s.copyWith(amountInSats: 0));
            break;
          case AmountInputStatus.failure:
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
                BlocBuilder<AmountInputCubit, AmountInputState>(
                  builder: (context, state) {
                    return Text(
                      '${state.balance != null ? state.balance.toString() : '---'} sats',
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
              onTap: () => context
                  .flow<PaymentFlowData>()
                  .update((state) => const PaymentFlowData(useQRCode: false)),
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
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(child: Container()),
                  BlocBuilder<AmountInputCubit, AmountInputState>(
                    builder: (context, state) {
                      return Text(
                        state.amount.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  const Text(
                    'sats',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        Expanded(
                          flex: 5,
                          child:
                              BlocBuilder<AmountInputCubit, AmountInputState>(
                            builder: (context, state) {
                              return Slider(
                                value: state.selectedPriority.value,
                                min: 0,
                                max: 2,
                                divisions: 2,
                                label: state.selectedPriority.name,
                                onChanged: (double value) {
                                  context
                                      .read<AmountInputCubit>()
                                      .selectedPriorityChanged(value);
                                },
                              );
                            },
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        Expanded(
                          flex: 5,
                          child:
                              BlocBuilder<AmountInputCubit, AmountInputState>(
                            builder: (context, state) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Visibility(
                                      visible: state.selectedPriority ==
                                          FeePriority.low,
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                          children: [
                                            const Text(
                                              'Low\nPriority',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const Text(
                                              '~ 60 min',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            Text(
                                              '${state.feeByPriority != null ? state.feeByPriority![FeePriority.low] : '---'} sats',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 243, 248, 187),
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Visibility(
                                      visible: state.selectedPriority ==
                                          FeePriority.medium,
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        child: Column(
                                          children: [
                                            const Text(
                                              'Standard\nPriority',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const Text(
                                              '~ 30 min',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            Text(
                                              '${state.feeByPriority != null ? state.feeByPriority![FeePriority.medium] : '---'} sats',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 243, 248, 187),
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Visibility(
                                      visible: state.selectedPriority ==
                                          FeePriority.high,
                                      child: Container(
                                        alignment: Alignment.topRight,
                                        child: Column(
                                          children: [
                                            const Text(
                                              'High\nPriority',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                            const Text(
                                              '~ 10 min',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            Text(
                                              '${state.feeByPriority != null ? state.feeByPriority![FeePriority.high] : '---'} sats',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 243, 248, 187),
                                                fontSize: 12,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                BlocBuilder<AmountInputCubit, AmountInputState>(
                  builder: (context, state) {
                    return NumericKeyboard(
                      onKeyboardTap: (value) {
                        var current = state.amount;
                        context.read<AmountInputCubit>().amountInputChanged(
                            current != 0 ? current.toString() + value : value);
                      },
                      textColor: const Color.fromARGB(255, 89, 172, 241),
                      rightButtonFn: () {
                        var current = state.amount;
                        if (current != 0) {
                          var currentStr = current.toString();
                          if (currentStr.length > 1) {}
                          context.read<AmountInputCubit>().amountInputChanged(
                              currentStr.length > 1
                                  ? currentStr.substring(
                                      0, currentStr.length - 1)
                                  : '0');
                        }
                      },
                      rightIcon: const Icon(
                        Icons.backspace,
                        color: Color.fromARGB(255, 89, 172, 241),
                      ),
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    );
                  },
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
                          child:
                              BlocBuilder<AmountInputCubit, AmountInputState>(
                            builder: (context, state) {
                              return ElevatedButton.icon(
                                onPressed: state.status !=
                                        AmountInputStatus.editingReady
                                    ? null
                                    : () {},
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 20,
                                ),
                                label: const Text(
                                  'Next',
                                  style: TextStyle(fontSize: 14),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey[900],
                                    disabledBackgroundColor:
                                        Colors.blueGrey[900],
                                    disabledForegroundColor:
                                        Colors.blueGrey[700]),
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
          ],
        ),
      ),
    );
  }
}
