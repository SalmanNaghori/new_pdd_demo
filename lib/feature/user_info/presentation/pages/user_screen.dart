import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pdd_demo/core/di/injection.dart';
import '../bloc/user_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<UserBloc>()..add(FetchUsersEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Users")),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            } else if (state is UserSuccess) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(title: Text(user.name), subtitle: Text(user.email));
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

