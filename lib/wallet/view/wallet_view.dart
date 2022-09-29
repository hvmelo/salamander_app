import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/app/view/drawer.dart';
import 'package:salamander_app/wallet/view/widgets.dart';
import 'package:salamander_app/wallet/wallet.dart';

class WalletView extends StatelessWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        return Scaffold(
          drawer: (state.status == WalletStatus.synced ||
                  state.status == WalletStatus.error)
              ? const AppDrawer()
              : null,
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.blue,
                      Colors.black,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    const WalletBalance(),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            const WalletCurrency(),
                            Expanded(
                              child: Container(),
                            ),
                            const WalletActions(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: (state.status != WalletStatus.synced),
                child: const WalletSetup(),
              ),
            ],
          ),
        );
      },
    );
  }
}
