import 'package:flutter/material.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0E1D3E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Task',
              style: themedata.textTheme.displayMedium,
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              height: 4,
              color: Colors.teal,
              endIndent: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              style: themedata.textTheme.displaySmall,
              controller: _titleController,
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Title is Mandatory";
                }
              },
              decoration: InputDecoration(
                hintText: 'Enter Task Title',
                hintStyle: themedata.textTheme.displaySmall,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              style: themedata.textTheme.displaySmall,
              controller: _descController,
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Description is Mandatory";
                }
              },
              decoration: InputDecoration(
                hintText: 'Enter Task Description',
                hintStyle: themedata.textTheme.displaySmall,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Container(
                    height: 48,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Add Task',
                        style: themedata.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
