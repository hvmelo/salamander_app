import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:salamander_app/receive/receive_coins.dart';

class ReceiveCoinsView extends StatelessWidget {
  const ReceiveCoinsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiveCoinsCubit, ReceiveCoinsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
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
