import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send_payment/pages/amount_input/amount_input.dart';
import 'package:salamander_app/send_payment/send_payment.dart';

class AmountInputView extends StatefulWidget {
  const AmountInputView({Key? key}) : super(key: key);

  @override
  State<AmountInputView> createState() => _AmountInputViewState();
}

class _AmountInputViewState extends State<AmountInputView> {
  final inputAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    inputAmountController
      //..text = state.input
      ..addListener(() => context
          .read<AmountInputCubit>()
          .amountInputChanged(inputAmountController.text));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    inputAmountController.dispose();
    super.dispose();
  }

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
        extendBodyBehindAppBar: true,
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
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        child: const Center(
                          child: Text(
                            'Please enter a Bitcoin address or a '
                            'Lightning Invoice',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: BlocListener<AmountInputCubit, AmountInputState>(
                  listener: (context, state) {
                    inputAmountController.text = state.amount;
                  },
                  child: TextField(
                    key: const Key('sendPayment_amountInput_textField'),
                    controller: inputAmountController,
                    minLines: 20,
                    maxLines: null,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 5),
                            child:
                                BlocBuilder<AmountInputCubit, AmountInputState>(
                              builder: (context, state) {
                                return ElevatedButton.icon(
                                  onPressed: () async {
                                    var cdata = await Clipboard.getData(
                                        Clipboard.kTextPlain);
                                    var copiedtext = cdata?.text;
                                    if (copiedtext != null) {
                                      inputAmountController.text = copiedtext;
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.paste,
                                    size: 20,
                                  ),
                                  label: const Text(
                                    'Paste from Clipboard',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromARGB(255, 4, 96, 171),
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
                    Row(
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
                                primary: Colors.blueGrey[900],
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
                    Expanded(
                      child: Container(),
                    ),
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
