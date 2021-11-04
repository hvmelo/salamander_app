import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:salamander_app/login/cubit/login_cubit.dart';
import 'package:salamander_app/login/view/widgets/email_input.dart';
import 'package:salamander_app/login/view/widgets/login_button.dart';
import 'package:salamander_app/login/view/widgets/password_input.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EmailInput(),
          SizedBox(height: MediaQuery.of(context).size.height / 35),
          const PasswordInput(),
          SizedBox(height: MediaQuery.of(context).size.height / 35),
          Container(
            width: MediaQuery.of(context).size.width / 1.4,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
            child: const MaterialButton(
              onPressed: null,
              child: Text('Create Wallet'),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 35),
          const LoginButton(),
        ],
      ),
    );
  }
}
