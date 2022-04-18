import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/functions/my_validators.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'widgets/loader.dart';

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
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthStateFailed) {
                //? show error msg
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.errorMsg),
                    ),
                  );
              }
            },
            builder: (context, state) {
              if ((state is AuthStateInit) || (state is AuthStateFailed)) {
                return _RegisterForm();
              } else if (state is AuthStateLoading) {
                return const Loader();
              } else {
                return const Text("Authenticated");
              }
            },
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
          _LoginButton(
            onPressed: () {
              final isValid = _formKey.currentState!.validate();
              if (isValid) {
                context.read<AuthCubit>().register(
                      _nameController.text,
                      _mobileController.text,
                    );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  final TextEditingController _controller;

  const _UsernameInput({
    Key? key,
    required TextEditingController controller,
  })  : _controller = controller,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      validator: MyValidators.validateName,
      decoration: const InputDecoration(labelText: 'Name'),
    );
  }
}

class _MobileInput extends StatelessWidget {
  final TextEditingController _controller;

  const _MobileInput({
    Key? key,
    required TextEditingController controller,
  })  : _controller = controller,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      validator: MyValidators.validateMobile,
      decoration: const InputDecoration(labelText: 'Mobile'),
      keyboardType: TextInputType.phone,
    );
  }
}

class _LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _LoginButton({Key? key, required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Register'),
      onPressed: onPressed,
    );
  }
}
