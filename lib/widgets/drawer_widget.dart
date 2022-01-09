import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:work_os/constants/constants.dart';
import 'package:work_os/inner_screen/profile.dart';
import 'package:work_os/inner_screen/upload_task.dart';
import 'package:work_os/screen/all_workers.dart';
import 'package:work_os/screen/task_screen.dart';

import '../user_state.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.cyan),
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Image.network(
                      'https://image.flaticon.com/icons/png/128/1055/1055672.png'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: Text(
                    'Work OS English',
                    style: TextStyle(
                        color: Constants.darkBlue,
                        fontSize: 22,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          _listTiles(
              label: 'All Tasks',
              fct: () {
                _navigateToAllTasksScreen(context);
              },
              icon: Icons.task_outlined),
          _listTiles(
              label: 'My account',
              fct: () {
                _navigateToProfileScreen(context);
              },
              icon: Icons.settings_outlined),
          _listTiles(
              label: 'Registered Workers',
              fct: () {
                _navigateToAllWorkersScreen(context);
              },
              icon: Icons.workspaces_outline),
          _listTiles(
            label: 'Add a task',
            fct: () {
              _navigateToAddTaskScreen(context);
            },
            icon: Icons.add_task,
          ),
          const Divider(
            thickness: 1,
          ),
          _listTiles(
            label: 'Logout',
            fct: () {
              _logout(context);
            },
            icon: Icons.logout,
          ),
        ],
      ),
    );
  }

  void _navigateToProfileScreen(context) {
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // final User? user = _auth.currentUser;
    // final String userID = user!.uid;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final String uid = user!.uid;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          userID: uid,
        ),
      ),
    );
  }

  void _navigateToAllWorkersScreen(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AllWorkersScreen(),
      ),
    );
  }

  void _navigateToAllTasksScreen(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const TasksScreen(),
      ),
    );
  }

  void _navigateToAddTaskScreen(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UploadTask(),
      ),
    );
  }

  void _logout(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    'https://image.flaticon.com/icons/png/128/1252/1252006.png',
                    height: 20,
                    width: 20,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Sign out',
                  ),
                ),
              ],
            ),
            content: Text(
              'Do you wanna Sign out',
              style: TextStyle(
                  color: Constants.darkBlue,
                  fontSize: 20,
                  fontStyle: FontStyle.italic),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserState(),
                    ),
                  );
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        });
  }

  Widget _listTiles(
      {required String label, required Function fct, required IconData icon}) {
    return ListTile(
      onTap: () {
        fct();
      },
      leading: Icon(
        icon,
        color: Constants.darkBlue,
      ),
      title: Text(
        label,
        style: TextStyle(
            color: Constants.darkBlue,
            fontSize: 20,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
