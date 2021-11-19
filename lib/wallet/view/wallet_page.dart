import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/app/app.dart';
import 'package:salamander_app/app/view/drawer.dart';
import 'package:salamander_app/data/repositories/mock_repository.dart';
import 'package:salamander_app/wallet/wallet.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: WalletPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.blue,
                Colors.black,
              ],
            ),
          ),
          child: BlocProvider<WalletCubit>(
            create: (context) =>
                WalletCubit(MockWalletRepository())..startSyncing(),
            child: const WalletView(),
          )),
    );
  }
}
