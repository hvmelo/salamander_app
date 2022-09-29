import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send_payment/send_payment.dart';
import 'package:salamander_app/send_payment/view/enter_amount/widgets/amount_input_form.dart';

import 'widgets/next_button.dart';

class EnterAmountView extends StatelessWidget {
  const EnterAmountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: true,
          title: const Text(
            'AMOUNT INPUT',
            style: TextStyle(fontSize: 18),
          ),
          leading: BlocBuilder<SendPaymentBloc, SendPaymentState>(
            builder: (context, state) {
              var theState = state as SendPaymentEnterAmountState;
              return GestureDetector(
                onTap: () => context
                    .read<SendPaymentBloc>()
                    .add(ManualAddressEntryRequested(theState.address)),
                child: const Icon(Icons.arrow_back_ios),
              );
            },
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: GestureDetector(
                  onTap: () => context.flow<SendPaymentState>().complete(),
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
                          '1000 sats',
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
              child: EnterAmountInputForm(),
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
                        child: Container(),
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
                      const Expanded(
                        flex: 4,
                        child: EnterAmountNextButton(),
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
    );
  }
}
