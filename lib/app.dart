import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/authentication/view/authentication_page.dart';
import 'package:salamander_app/data/mock_wallet_repository.dart';
import 'package:salamander_app/wallet/cubit/wallet_cubit.dart';
import 'package:salamander_app/wallet/view/wallet_page.dart';

import 'authentication/cubit/authentication_cubit.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salamander',
      initialRoute: '/',
      routes: {
        '/': (context) {
          // return BlocProvider(
          //   create: (context) =>
          //       WalletCubit(MockWalletRepository())..startSyncing(),
          //   child: WalletPage(),
          // );
          return BlocProvider(
            create: (context) => AuthenticationCubit(),
            child: AuthenticationPage(),
          );
        },
      },
      theme: ThemeData(
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: Colors.blue.shade300,
            padding: const EdgeInsets.all(14),
            //side: const BorderSide(color: Colors.white60),
            //shape: const StadiumBorder(),
            textStyle: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
