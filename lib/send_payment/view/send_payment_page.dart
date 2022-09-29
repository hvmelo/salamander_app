import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';
import 'package:salamander_app/send_payment/send_payment.dart';
import 'package:salamander_app/util/page_routes.dart';

class SendPaymentPage extends StatelessWidget {
  const SendPaymentPage({Key? key}) : super(key: key);

  static Route route() {
    return BottomUpPageRoute<void>(
      builder: (_) => const SendPaymentPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.amber,
        child: BlocProvider<SendPaymentBloc>(
          create: (context) => SendPaymentBloc(
              walletRepository: context.read<WalletRepository>())
            ..add(QRScanRequested()),
          child: const SendPaymentFlow._(),
        ),
      ),
    );
  }
}

class SendPaymentFlow extends StatelessWidget {
  const SendPaymentFlow._();

  List<Page> onGeneratePages(SendPaymentState state, List<Page> pages) {
    return [
      QRScanPage.page(),
      if (state is SendPaymentEnterAddressState) EnterAddressPage.page(),
      if (state is SendPaymentEnterAmountState) EnterAmountPage.page()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<SendPaymentState>(
      state: context.watch<SendPaymentBloc>().state,
      onGeneratePages: onGeneratePages,
    );
  }
}
