import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:coinslib/coinslib.dart';
import 'package:salamander_app/util/btc_input_parser/bitcoin_address.dart';

import 'lightning_invoice.dart';

class BTCInputParser {
  static Object? parseInput(String input) {
    if (validateAddress(input, testnet)) {
      return BitcoinAddress(address: input);
    } else {
      try {
        var req = Bolt11PaymentRequest(input);
        if (req.prefix.name != 'lntb') {
          /* (lnbc for Bitcoin mainnet, lntb for Bitcoin testnet, lntbs for 
            Bitcoin signet, and lnbcrt for Bitcoin regtest) */
          return null;
        }

        return LightningInvoice(
            paymentRequest: req.paymentRequest,
            network: LightningNetwork.testnet,
            amount: req.amount.toBigInt(),
            timestamp: req.timestamp);
      } catch (e) {
        return null;
      }
    }
  }
}
