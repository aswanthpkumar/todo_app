import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/task_model.dart';
import 'package:todoapp/screens/add_task_page.dart';
import 'package:todoapp/screens/login_page.dart';
import 'package:todoapp/services/auth_service.dart';
import 'package:todoapp/services/tak_service.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  TaskServices _taskServices = TaskServices();
  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0E1D3E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskView(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Hi",
                      style: themedata.textTheme.displayMedium,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Aswanth',
                      style: themedata.textTheme.displayMedium,
                    ),
                  ],
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () {
                      final user = FirebaseAuth.instance.currentUser;
                      AuthService().logout().then((value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LoginView()),
                          (Route<dynamic> route) => false,
                        );
                      });
                    },
                    icon: const Icon(Icons.logout),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Your To-dos',
              style: themedata.textTheme.displayMedium,
            ),
            const SizedBox(
              height: 15,
            ),
            StreamBuilder<List<TaskModel>>(
              stream: _taskServices.getAllTask(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Some error Occured',
                      style: themedata.textTheme.displaySmall,
                    ),
                  );
                }
                if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      'No task added',
                      style: themedata.textTheme.displaySmall,
                    ),
                  );
                }
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  List<TaskModel> task = snapshot.data ?? [];

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      TaskModel _taskModel = TaskModel();
                      final _task = task[index];
                      // ignore: avoid_print
                      print(_task);
                      return Card(
                        color: themedata.scaffoldBackgroundColor,
                        elevation: 5.0,
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.circle_outlined,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            "${_task.title}",
                            style: themedata.textTheme.displaySmall,
                          ),
                          subtitle: Text(
                            "${_task.body}",
                            style: themedata.textTheme.displaySmall,
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                             AddTaskView(task: _task,),
                                      ),
                                    );
                                  },
                                  color: Colors.teal,
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _taskServices.deleteTask(_task.id);
                                  },
                                  color: Colors.red,
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
