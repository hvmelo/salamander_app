import 'package:flutter/material.dart';
import 'package:salamander_app/wallet/view/widgets/wallet_actions.dart';
import 'package:salamander_app/wallet/view/widgets/wallet_balance.dart';
import 'package:salamander_app/wallet/view/widgets/wallet_currency.dart';
import 'package:salamander_app/wallet/view/widgets/wallet_refresh.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: WalletPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage('assets/images/bg1.jpg'),
            //   fit: BoxFit.cover,
            // ),
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
                      const SizedBox(height: 15),
                      const WalletRefresh(),
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
      ),
    );
  }
}
