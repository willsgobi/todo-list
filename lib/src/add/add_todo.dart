import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({super.key});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final _formKey = GlobalKey<FormState>();
  final todoListController = TextEditingController();

  @override
  void dispose() {
    todoListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar nova tarefa"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: todoListController,
                decoration: const InputDecoration(hintText: "Adicionar tarefa"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "O campo precisa ser preenchido!";
                  }

                  if (value.length < 4) {
                    return "A terefa precisa ter mais de 3 digitos";
                  }

                  return null;
                },
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context, todoListController.text);
                    }
                  },
                  icon: const Icon(Icons.note_add),
                  label: const Text("Adicionar"))
            ],
          ),
        ),
      ),
    );
  }
}
