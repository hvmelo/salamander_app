import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send/bloc/send_coins_bloc.dart';
import 'widgets/address_or_invoice_input.dart';
import 'widgets/paste_from_clipboard_button.dart';

class EnterManuallyView extends StatelessWidget {
  const EnterManuallyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendCoinsBloc, SendCoinsState>(
      buildWhen: (previous, current) => current is SendCoinsManualEnterState,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              automaticallyImplyLeading: true,
              title: const Text(
                'ENTER MANUALLY',
                style: TextStyle(fontSize: 18),
              ),
              leading: GestureDetector(
                onTap: () =>
                    context.read<SendCoinsBloc>().add(QRScanRequested()),
                child: const Icon(Icons.arrow_back_ios),
              ),
              actions: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: () => context.flow<SendCoinsState>().complete(),
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
                  child: AddressOrInvoiceInput(),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: PasteFromClipboardButton(),
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
      },
    );
  }
}
