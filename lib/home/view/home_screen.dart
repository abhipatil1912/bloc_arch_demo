import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc/user_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserEventFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserStateInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserStateFailed) {
            return Center(child: Text(state.errorMsg));
          } else {
            final users = (state as UserStateSuccess).users;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(users[index].avatar ?? ""),
                ),
                title: Text(users[index].name ?? ""),
                subtitle: Text("id: ${users[index].id ?? ""}"),
              ),
            );
          }
        },
      ),
    );
  }
}
