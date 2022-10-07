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
            title: const Text(
              'ENTER AMOUNT',
              style: TextStyle(fontSize: 18),
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
                          fontSize: 40,
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
                      fontSize: 16,
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
            Column(
              children: [
                NumericKeyboard(
                  onKeyboardTap: (value) => context
                      .read<AmountInputCubit>()
                      .amountInputChanged(value),
                  textColor: const Color.fromARGB(255, 89, 172, 241),
                  rightButtonFn: () {},
                  rightIcon: const Icon(
                    Icons.backspace,
                    color: Color.fromARGB(255, 89, 172, 241),
                  ),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // context
                              //     .read<AmountInputCubit>()
                              //     .validateAndSubmit();
                            },
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
                            ),
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
