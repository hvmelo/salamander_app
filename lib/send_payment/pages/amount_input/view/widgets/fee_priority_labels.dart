// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/data/repositories/transaction_fees_repository.dart';
import 'package:salamander_app/send_payment/pages/amount_input/amount_input.dart';

class FeePriorityLabels extends StatelessWidget {
  const FeePriorityLabels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmountInputCubit, AmountInputState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Visibility(
                visible: state.selectedPriority == FeePriority.low,
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
                        '${state.totalFeeByPriority != null ? state.totalFeeByPriority![FeePriority.low] : '---'} sats',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 243, 248, 187),
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
                visible: state.selectedPriority == FeePriority.standard,
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
                        '${state.totalFeeByPriority != null ? state.totalFeeByPriority![FeePriority.standard] : '---'} sats',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 243, 248, 187),
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
                visible: state.selectedPriority == FeePriority.high,
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
                        '${state.totalFeeByPriority != null ? state.totalFeeByPriority![FeePriority.high] : '---'} sats',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 243, 248, 187),
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
    );
  }
}
