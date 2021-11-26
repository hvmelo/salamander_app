import 'package:flutter/material.dart';
import 'package:salamander_app/wallet/view/widgets.dart';

class WalletView extends StatelessWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.red,
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
          Container(
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
        ],
      ),
    );
  }
}
