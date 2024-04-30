import 'package:flutter/material.dart';
import 'package:todoapp/models/task_model.dart';
import 'package:todoapp/services/tak_service.dart';
import 'package:uuid/uuid.dart';

class AddTaskView extends StatefulWidget {
  final TaskModel? task;
  const AddTaskView({super.key, this.task});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TaskServices _taskService = TaskServices();

  bool _edit = false;
  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  loadData() {
    if (widget.task != null) {
      setState(() {
        _titleController.text = widget.task!.title!;
        _descController.text = widget.task!.body!;
        _edit = true;
      });
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  final _taskKey = GlobalKey<FormState>();

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
        child: Form(
          key: _taskKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _edit == true
                  ? Text(
                      'Update Task',
                      style: themedata.textTheme.displayMedium,
                    )
                  : Text(
                      'Add New Task',
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
                child: GestureDetector(
                  onTap: () {
                    if (_taskKey.currentState!.validate()) {
                      if (_edit) {
                        TaskModel _taskModel = TaskModel(
                          id: widget.task?.id,
                          title: _titleController.text,
                          body: _descController.text,
                        );
                        _taskService.updateTask(_taskModel).then(
                              (value) => Navigator.pop(context),
                            );
                      } else {
                        _addTask();
                      }
                    }
                  },
                  child: Container(
                    height: 48,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: _edit == true
                            ? Text(
                                'Update Task',
                                style: themedata.textTheme.bodyMedium,
                              )
                            : Text(
                                'Add Task',
                                style: themedata.textTheme.bodyMedium,
                              )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addTask() async {
    var id = Uuid().v1();

    TaskModel _taskModel = TaskModel(
      title: _titleController.text,
      body: _descController.text,
      id: id,
      status: 1,
      createdAt: DateTime.now(),
    );

    final task = await _taskService.createTask(_taskModel);

    if (task != null) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task Created'),
        ),
      );
    }
  }
}
