import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../bloc/register_bloc/register_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state.status == FormzStatus.submissionFailure) {
                //? show error msg
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text("Authentication Failure"),
                    ),
                  );
              }
            },
            child: _RegisterForm(),
          ),
        ),
      ),
    );
  }
}

//? register form
class _RegisterForm extends StatelessWidget {
  _RegisterForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _UsernameInput(controller: _nameController),
          const Padding(padding: EdgeInsets.all(12)),
          _MobileInput(controller: _mobileController),
          const Padding(padding: EdgeInsets.all(12)),
          const _LoginButton(),
        ],
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({
    Key? key,
    required TextEditingController controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return TextField(
          onChanged: (username) => context
              .read<RegisterBloc>()
              .add(RegisterUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: state.username.invalid ? 'Enter name' : null,
          ),
        );
      },
    );
  }
}

class _MobileInput extends StatelessWidget {
  const _MobileInput({
    Key? key,
    required TextEditingController controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return TextField(
          onChanged: (password) =>
              context.read<RegisterBloc>().add(RegisterMobileChanged(password)),
          decoration: InputDecoration(
            labelText: 'Mobile',
            errorText: state.mobile.invalid ? 'Invalid mobile' : null,
          ),
          keyboardType: TextInputType.phone,
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                child: const Text('Register'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<RegisterBloc>().add(RegisterSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}
