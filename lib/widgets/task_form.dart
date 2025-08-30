import 'package:flutter/material.dart';
import '../../models/task_model.dart';

class TaskForm extends StatefulWidget {
  final Task? task;
  const TaskForm({super.key, this.task});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  String? _notes;
  bool _isDone = false;

  @override
  void initState() {
    super.initState();
    _title = widget.task?.title ?? '';
    _notes = widget.task?.notes ?? '';
    _isDone = widget.task?.isDone == 1;
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.task != null;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 20),
      child: Form(
        key: _formKey,
        child: Wrap(
          children: [
            Text(isEdit ? "Edit Task" : "Add Task",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: _title,
              decoration: const InputDecoration(labelText: "Title"),
              validator: (v) =>
              (v == null || v.isEmpty) ? "Enter a title" : null,
              onSaved: (v) => _title = v!,
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: _notes,
              decoration: const InputDecoration(labelText: "Notes"),
              validator: (v) =>
              (v == null || v.isEmpty) ? "Enter a note" : null,
              onSaved: (v) => _notes = v,
            ),
            Row(
              children: [
                Checkbox(
                  value: _isDone,
                  onChanged: (val) => setState(() => _isDone = val!),
                ),
                const Text("Completed")
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final task = Task(
                    id: widget.task?.id,
                    title: _title,
                    notes: _notes,
                    isDone: _isDone ? 1 : 0,
                    createdAt: widget.task?.createdAt,
                  );
                  Navigator.pop(context, task);
                }
              },
              child: Text(isEdit ? "Save Changes" : "Add Task"),
            )
          ],
        ),
      ),
    );
  }
}
