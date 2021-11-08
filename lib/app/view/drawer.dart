import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salamander_app/app/bloc/app_bloc.dart' as app_bloc;

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((app_bloc.AppBloc bloc) => bloc.state.user);

    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightBlue[900],
            ),
            // child: const Text(
            //   'Salamander App',
            //   style: TextStyle(color: Colors.white),
            // ),
            child: Align(
              alignment: const Alignment(0, -1 / 3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const CircleAvatar(
                    radius: 34.0,
                    backgroundImage: null,
                    child: Icon(Icons.person_outline, size: 34.0),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    user.email ?? '',
                    style: const TextStyle(color: Colors.white),
                  ),
                  //const SizedBox(height: 4),
                  //Text(_user.name ?? ''),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Log out'),
            onTap: () => context
                .read<app_bloc.AppBloc>()
                .add(app_bloc.AppLougoutRequested()),
          ),
        ],
      ),
    );
  }
}
