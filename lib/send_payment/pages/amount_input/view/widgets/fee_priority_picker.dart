import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/data/repositories/transaction_fees_repository.dart';
import 'package:salamander_app/send_payment/pages/amount_input/amount_input.dart';

class FeePriorityPicker extends StatelessWidget {
  const FeePriorityPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmountInputCubit, AmountInputState>(
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
                .selectedPriorityChanged(FeePriority.fromValue(value));
          },
        );
      },
    );
  }
}
