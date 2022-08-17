import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:salamander_app/receive/view/receive_coins_page.dart';

class WalletActions extends StatelessWidget {
  const WalletActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: OutlinedButton.icon(
              label: const Text('RECEIVE'),
              icon: const Icon(Icons.download),
              onPressed: () => _displayDialog(context),
              // onPressed: () {
              //   Navigator.of(context).push<void>(ReceiveCoinsPage.route());
              // },
            ),
          ),
          Container(
            width: 1,
            height: 30,
            color: Colors.blue.shade200,
          ),
          Expanded(
            child: OutlinedButton.icon(
              label: const Text('SEND'),
              icon: const Icon(Icons.upload),
              onPressed: () {
                print('Send Pressed');
              },
            ),
          ),
        ],
      ),
    );
  }

  void _displayDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );
        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.close),
            ),
            title: const Text('RECEIVE'),
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: Colors.black,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      color: Colors.white,
                      child: QrImage(
                        data: '1234567890',
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            //const WalletCurrency(),
                            const SizedBox(height: 15),

                            //const WalletRefresh(),
                            Expanded(
                              child: Container(),
                            ),
                            //const WalletActions(),
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
      },
    );
  }
}
