import 'package:flutter/material.dart';
import 'package:todo_list/src/models/ToDo.dart';

import '../add/add_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var todoList = <ToDo>[];
  int? indexToRemove;
  var initialList = <ToDo>[];
  final titleFilter = TextEditingController();

  setIndexToRemove(int index, String todoTitle) {
    setState(() {
      indexToRemove = index;
    });

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Text("Deseja remover o item $todoTitle?"),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    indexToRemove = null;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Operação cancelada!")));
                },
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    todoList.removeAt(index);
                  });
                  indexToRemove = null;
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Tarefa deletada com sucesso!"),
                    backgroundColor: Colors.green,
                  ));
                },
                child: const Text("Remover"),
              )
            ],
          );
        });
  }

  filterList() {
    if (initialList.isEmpty) {
      setState(() {
        initialList = todoList;
      });
    }

    var newList = todoList
        .where((element) => element.title.contains(titleFilter.text))
        .toList();

    if (newList.isEmpty || titleFilter.text.isEmpty) {
      setState(() {
        todoList = initialList;
      });
    } else {
      setState(() {
        todoList = newList;
      });
    }
  }

  @override
  void dispose() {
    titleFilter.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              todoList.isNotEmpty
                  ? TextFormField(
                      controller: titleFilter,
                      decoration:
                          const InputDecoration(hintText: "Pesquisar na lista"),
                      onChanged: (value) {
                        filterList();
                      },
                    )
                  : const SizedBox(),
              initialList.isNotEmpty
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          todoList = initialList;
                          initialList = [];
                        });
                        titleFilter.text = "";
                      },
                      child: const Text("Remover filtro de pesquisa"))
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width,
                child: todoList.isEmpty
                    ? const Center(child: Text("Não há itens na lista"))
                    : ListView(
                        children: todoList.map((e) {
                          var index = todoList.indexOf(e);
                          return Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(.2),
                                      offset: const Offset(1, 6),
                                      blurRadius: 5,
                                      spreadRadius: 1)
                                ]),
                            width: MediaQuery.of(context).size.width,
                            height: 75,
                            child: Row(
                              children: [
                                Checkbox(
                                    value: indexToRemove == index,
                                    onChanged: (value) {
                                      setIndexToRemove(index, e.title);
                                    }),
                                Text(e.title)
                              ],
                            ),
                          );
                        }).toList(),
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            var currentList = todoList;
            var newTodo = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddToDo()));

            if (newTodo != null) {
              final todo = ToDo(title: newTodo);
              currentList.add(todo);
              setState(() {
                todoList = currentList;
              });
            }
          },
          label: const Text("Nova tarefa"),
          icon: const Icon(Icons.note_add)),
    );
  }
}
