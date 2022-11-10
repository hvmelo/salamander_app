import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:salamander_app/send_payment/pages/amount_input/amount_input.dart';

class AmountInputNumericKeyboard extends StatelessWidget {
  const AmountInputNumericKeyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AmountInputCubit, AmountInputState>(
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
                      ? currentStr.substring(0, currentStr.length - 1)
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
    );
  }
}
