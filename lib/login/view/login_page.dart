import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/data/repositories/authentication_repository.dart';
import 'package:salamander_app/login/login.dart';
import 'package:salamander_app/login/view/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

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
          child: BlocProvider<LoginCubit>(
            create: (context) =>
                LoginCubit(context.read<AuthenticationRepository>()),
            child: const LoginForm(),
          )),
    );
  }
}
