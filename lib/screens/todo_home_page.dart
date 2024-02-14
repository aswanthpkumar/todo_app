import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/add_task_page.dart';
import 'package:todoapp/screens/login_page.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
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
                      FirebaseAuth.instance.signOut().then(
                            (value) => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const LoginView()),
                                (Route<dynamic> route) => false),
                          );
                      print(user!.email);
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
            ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
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
                        'Todo 1',
                        style: themedata.textTheme.displaySmall,
                      ),
                      subtitle: Text(
                        'Complete the assignment before 10 am tomorrow',
                        style: themedata.textTheme.displaySmall,
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              color: Colors.teal,
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {},
                              color: Colors.red,
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
