import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';
import '../../util/page_routes.dart';
import '../bloc/send_coins_bloc.dart';
import '../send_coins.dart';
import 'enter_address/enter_address_page.dart';

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
              SendCoinsBloc(walletRepository: context.read<WalletRepository>()),
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
      if (state.entryType == AddressEntryType.manual) EnterAddressPage.page()
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
