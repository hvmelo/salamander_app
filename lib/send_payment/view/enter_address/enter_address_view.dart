import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send_payment/send_payment.dart';
import 'widgets/address_input_form.dart';
import 'widgets/next_button.dart';
import 'widgets/paste_from_clipboard_button.dart';

class EnterAddressView extends StatelessWidget {
  const EnterAddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendPaymentBloc, SendPaymentState>(
      listenWhen: (previous, current) =>
          current is SendPaymentEnterAddressState,
      listener: (context, state) {
        var theState = state as SendPaymentEnterAddressState;
        if (theState.status == SendPaymentAddressFormStatus.submissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                content: Text(theState.errorMessage ?? 'Submission failure'),
              ),
            );
          context
              .read<SendPaymentBloc>()
              .add(SubmissionFailureMessageDisplayed());
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
              'ENTER ADDRESS',
              style: TextStyle(fontSize: 18),
            ),
            leading: BlocBuilder<SendPaymentBloc, SendPaymentState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () =>
                      context.read<SendPaymentBloc>().add(QRScanRequested()),
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
                child: EnterAddressInputForm(),
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
                            child: EnterAddressPasteButton(),
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
                        const Expanded(
                          flex: 4,
                          child: EnterAddressNextButton(),
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
