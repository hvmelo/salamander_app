import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/send/bloc/send_coins_bloc.dart';
import 'package:salamander_app/send/view/qr_scan/widgets/qr_view_widget.dart';

class QRScanView extends StatelessWidget {
  const QRScanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            QRViewWidget(),
            Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Container(
                  height: 70,
                  child: Column(
                    children: [
                      BlocBuilder<SendCoinsBloc, SendCoinsState>(
                        builder: (context, state) {
                          return ElevatedButton.icon(
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
                          );
                        },
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
  }
}
