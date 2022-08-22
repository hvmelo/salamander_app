import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';
import '../../util/page_routes.dart';
import '../send_coins.dart';

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
        child: BlocProvider<SendCoinsBloc>(
          create: (context) =>
              SendCoinsBloc(walletRepository: context.read<WalletRepository>()),
          child: const SendCoinsView(),
        ),
      ),
    );
  }
}
