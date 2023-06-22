import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/sign_up/sign_up.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width / 1.3,
          child: TextField(
            key: const Key('signUpForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<SignUpCubit>().passwordChanged(password),
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            decoration: const  InputDecoration(
              hintStyle: TextStyle(
                color: Colors.white,
              ),
              labelText: 'Password',
              helperText: '',
              //errorText: state.password.displayError != null ? 'invalid password' : null,
              labelStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
