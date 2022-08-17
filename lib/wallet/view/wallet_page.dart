import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/data/repositories/wallet_repository.dart';
import 'package:salamander_app/wallet/wallet.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: WalletPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: BlocProvider<WalletBloc>(
          create: (context) => WalletBloc(
            walletRepository: context.read<WalletRepository>(),
          )..add(WalletInit()),
          child: const WalletView(),
        ),
      ),
    );
  }
}
