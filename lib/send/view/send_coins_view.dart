import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../send_coins.dart';

class SendCoinsView extends StatelessWidget {
  const SendCoinsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendCoinsBloc, SendCoinsState>(
      builder: (context, state) {
        var scanArea = (MediaQuery.of(context).size.width < 400 ||
                MediaQuery.of(context).size.height < 400)
            ? 150.0
            : 300.0;
        return Scaffold(
          backgroundColor: Colors.black,
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.close),
            ),
            title: const Text(
              'SEND COINS',
              style: TextStyle(fontSize: 18),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: QRView(
                    key: state.qrKey,
                    onQRViewCreated: ((controller) {
                      context
                          .read<SendCoinsBloc>()
                          .add(QRViewCreated(controller));
                    }),
                    overlay: QrScannerOverlayShape(
                        borderColor: Colors.red,
                        borderRadius: 10,
                        borderLength: 30,
                        borderWidth: 10,
                        cutOutSize: scanArea),
                    onPermissionSet: (ctrl, p) =>
                        _onPermissionSet(context, ctrl, p),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: (state is SendCoinsQRRead)
                        ? Text(
                            '''Barcode Type: ${describeEnum(state.qrResult.format)}   
                               Data: ${state.qrResult.code}''')
                        : const Text('Scan a code'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    //log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
