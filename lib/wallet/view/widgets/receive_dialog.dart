import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveCoinsDialog extends StatelessWidget {
  const ReceiveCoinsDialog({Key? key, required String address})
      : _address = address,
        super(key: key);

  final String _address;

  @override
  Widget build(BuildContext context) {
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
          'RECEIVE FUNDS',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: Container(),
            ),
            Container(
              color: Colors.white,
              child: QrImage(
                data: 'bitcoin:$_address',
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      _address,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => Clipboard.setData(
                        ClipboardData(text: _address),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Copy to clipboard',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.copy,
                            color: Colors.blue,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 70,
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Respond to button press
                    },
                    icon: Image.asset(
                      'assets/images/lightning.png',
                      width: 20,
                      height: 20,
                    ),
                    label: const Text(
                      'Lightning Invoice',
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
      ),
    );
  }
}
