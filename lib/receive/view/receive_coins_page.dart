import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';
import 'package:salamander_app/receive/receive_coins.dart';

class ReceiveCoinsPage extends StatelessWidget {
  const ReceiveCoinsPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const ReceiveCoinsPage(),
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: BlocProvider<ReceiveCoinsCubit>(
        create: (context) => ReceiveCoinsCubit(
            walletRepository: context.read<WalletRepository>()),
        child: const ReceiveCoinsView(),
      ),
    ));
  }
}
