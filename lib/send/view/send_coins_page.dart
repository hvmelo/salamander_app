import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';
import 'package:salamander_app/send/send_coins.dart';
import 'package:salamander_app/util/page_routes.dart';

class SendCoinsPage extends StatelessWidget {
  const SendCoinsPage({Key? key}) : super(key: key);

  static Route route() {
    return BottomUpPageRoute<void>(
      builder: (_) => const SendCoinsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.amber,
        child: BlocProvider<SendCoinsBloc>(
          create: (context) =>
              SendCoinsBloc(walletRepository: context.read<WalletRepository>())
                ..add(QRScanRequested()),
          child: const SendCoinsFlow(),
        ),
      ),
    );
  }
}

class SendCoinsFlow extends StatelessWidget {
  const SendCoinsFlow({Key? key}) : super(key: key);

  List<Page> onGeneratePages(SendCoinsState state, List<Page> pages) {
    return [
      QRScanPage.page(),
      if (state is SendCoinsManualEnterState) EnterManuallyPage.page()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<SendCoinsState>(
      state: context.watch<SendCoinsBloc>().state,
      onGeneratePages: onGeneratePages,
    );
  }
}
