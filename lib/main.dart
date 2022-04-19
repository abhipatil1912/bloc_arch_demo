import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/bloc/auth_bloc/auth_bloc.dart';
import 'auth/bloc/register_bloc/register_bloc.dart';
import 'auth/view/register_screen.dart';
import 'home/bloc/user_bloc/user_bloc.dart';
import 'home/view/home_screen.dart';
import 'splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerBloc = RegisterBloc();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => registerBloc,
          ),
          BlocProvider(
            create: (_) => AuthBloc(registerBloc),
          ),
          BlocProvider(
            create: (_) => UserBloc(),
          ),
        ],
        child: const App(),
      ),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    checkAndUpdateAuthStatus();
  }

  /// checks the user is sign-in or not & updates the state
  Future<void> checkAndUpdateAuthStatus() async {
    // pretending to read the token from local storage
    await Future.delayed(const Duration(seconds: 1));
    context.read<AuthBloc>().add(AuthStateChanged(AuthState.authenticated));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        switch (state) {
          case AuthState.unknown:
            return const SplashScreen();
          case AuthState.authenticated:
            return const HomeScreen();
          case AuthState.unauthenticated:
            return const RegisterScreen();
        }
      },
    );
  }
}
