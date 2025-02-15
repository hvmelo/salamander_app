import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SendCoinsDialog extends StatelessWidget {
  const SendCoinsDialog({Key? key, required String address})
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
          'SEND COINS',
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
              child: QrImageView(
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Copy to clipboard',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
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
              height: 100,
              child: Column(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: Container(),
                  ),
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
                      backgroundColor: Colors.blueGrey[900],
                    ),
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
