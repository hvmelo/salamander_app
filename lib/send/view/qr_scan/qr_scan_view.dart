import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:salamander_app/send/bloc/send_coins_bloc.dart';

class QRScanView extends StatefulWidget {
  const QRScanView({Key? key}) : super(key: key);

  @override
  State<QRScanView> createState() => _QRScanViewState();
}

class _QRScanViewState extends State<QRScanView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendCoinsBloc, SendCoinsState>(
      listener: (context, state) {
        // if (state is QRScanCodeRead) {
        //   //Navigator.of(context).push(route)
        // }
      },
      builder: (context, state) {
        var scanArea = MediaQuery.of(context).size.width * 0.5;
        return Scaffold(
          backgroundColor: Colors.black,
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: GestureDetector(
              onTap: () => context.flow<SendCoinsState>().complete(),
              child: const Icon(Icons.close),
            ),
            title: const Text(
              'SEND COINS',
              style: TextStyle(fontSize: 18),
            ),
          ),
          body: Container(
            color: Colors.black,
            child: Stack(
              children: <Widget>[
                Visibility(
                  visible: state is SendCoinsQRReadState,
                  child: QRView(
                    key: GlobalKey(debugLabel: 'QR'),
                    onQRViewCreated: (controller) => context
                        .read<SendCoinsBloc>()
                        .add(QRViewCreated(controller)),
                    overlay: QrScannerOverlayShape(
                        borderColor: Colors.blue,
                        borderRadius: 15,
                        borderLength: 20,
                        borderWidth: 15,
                        overlayColor: const Color.fromRGBO(0, 0, 0, 60),
                        cutOutSize: scanArea),
                    onPermissionSet: (ctrl, p) =>
                        _onPermissionSet(context, ctrl, p),
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      height: 70,
                      child: Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              context
                                  .read<SendCoinsBloc>()
                                  .add(ManualEntryRequested());
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 20,
                            ),
                            label: const Text(
                              'Enter address manually',
                              style: TextStyle(fontSize: 14),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey[900],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
        const SnackBar(content: Text('No permission to access the camera')),
      );
    }
  }
}
