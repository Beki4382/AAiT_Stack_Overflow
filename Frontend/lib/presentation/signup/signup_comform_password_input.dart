import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signup_validation/application/user_bloc/signup_event.dart';

import '../../application/user_bloc/signup_bloc.dart';
import '../../application/user_bloc/singup_state.dart';
import '../../login_theme.dart';

class ConfirmPasswordInput extends StatelessWidget {
  ConfirmPasswordInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  var outlineInputBorder = OutlineInputBorder(
    gapPadding: 8,
    borderSide:
        const BorderSide(width: 1.2, color: Color.fromARGB(255, 9, 144, 153)),
    borderRadius: BorderRadius.circular(40),
  );
  var outlineErrorBorder = OutlineInputBorder(
    gapPadding: 8,
    borderSide: const BorderSide(width: 1.2, color: Colors.red),
    borderRadius: BorderRadius.circular(40),
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingupBloc, SignupState>(builder: (context, state) {
      return Container(
        height: 90,
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        child: TextFormField(
          initialValue: state.confirmPassword.value,
          focusNode: focusNode,
          obscureText: true,
          showCursor: true,
          style: LoginTheme.textTheme.headline2,
          decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 16),
            border: outlineInputBorder,
            focusedErrorBorder: outlineErrorBorder,
            errorBorder: outlineErrorBorder,
            focusedBorder: outlineInputBorder,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 15, right: 5),
              child: Icon(
                Icons.person_outline,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            hintText: "Confirm password",
            hintStyle: LoginTheme.textTheme.headline4,
            labelText: "Confirm password",
            labelStyle: LoginTheme.textTheme.headline3,
            errorText:
                state.confirmPassword.invalid ? 'Password do not match' : null,
          ),
          onChanged: (value) {
            context.read<SingupBloc>().add(ConfirmPasswordChanged(
                password: state.password.value, confirmPassword: value));
          },
          textInputAction: TextInputAction.done,
        ),
      );
    });
  }
}
