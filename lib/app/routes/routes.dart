import 'package:flutter/widgets.dart';
import 'package:salamander_app/app/app.dart';
import 'package:salamander_app/login/login.dart';
import 'package:salamander_app/wallet/wallet.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [WalletPage.page()];
    case AppStatus.unauthenticated:
    default:
      return [LoginPage.page()];
  }
}
