import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/app/app.dart';
import 'package:salamander_app/data/repositories/authentication_repository.dart';
import 'package:salamander_app/data/repositories/wallet/wallet_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  final walletRepository =
      WalletRepository(authenticationRepository: authenticationRepository);
  BlocOverrides.runZoned(
    () => runApp(App(
      authenticationRepository: authenticationRepository,
      walletRepository: walletRepository,
    )),
    blocObserver: AppBlocObserver(),
  );
}
