import 'package:flutter/material.dart';

class Task {
  String taskTitle;
  bool completed;

  Task({required this.taskTitle, this.completed = false}); // Sets the class to take a string and set the task status at always a default of uncompleted
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks Book',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 113, 186, 245)),
        useMaterial3: true,
      ),
      home: const TaskListScreen(title: 'Task Book'),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key, required this.title});

  final String title;

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
List<Task> tasks = [];
final TextEditingController _taskNameController = TextEditingController();

  void _addTask() {
      if (_taskNameController.text.isNotEmpty) {
        setState(() {
            tasks.add(Task(taskTitle: _taskNameController.text));
            _taskNameController.clear();
          });
      }
  }

  void _removeTask(index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

          TextField(
          controller: _taskNameController,
          decoration: InputDecoration(
          labelText: 'Add Task Name',
          border: OutlineInputBorder(),
          ),
          ),

          ElevatedButton(
            onPressed: _addTask,
             child: const Text("Add Task"),
             ),

          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tasks[index].taskTitle),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        IconButton(
                          icon: Icon(
                            tasks[index].completed
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                          ),

                          onPressed: () {
                            setState(() {
                              tasks[index].completed = !tasks[index].completed;
                            });
                          },

                        ),

                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            _removeTask(index);
                          },
                        ),

                      ],
                    ),

                    onTap: () {
                      setState(() {
                        tasks[index].completed = !tasks[index].completed;
                      });
                    },

                  );
                }
              ),
            )

          ],
        ),
      ),
    );
  }
}