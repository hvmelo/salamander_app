import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/data/repositories/authentication_repository.dart';
import 'package:salamander_app/sign_up/sign_up.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.blue,
                Colors.black,
              ],
            ),
          ),
          child: BlocProvider<SignUpCubit>(
            create: (context) =>
                SignUpCubit(context.read<AuthenticationRepository>()),
            child: const SignUpForm(),
          )),
    );
  }
}
