import 'package:flutter/material.dart';
import 'package:todo_list/src/home/home.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login - ToDo List"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return "O e-mail deve ser preenchido!";
                  }

                  if (!emailRegex.hasMatch(email)) {
                    return "Insira um e-mail válido!";
                  }

                  if (email != "developer@email.com") {
                    return "Usuário ou senha inválidos!";
                  }

                  return null;
                },
                decoration:
                    const InputDecoration(hintText: "Insira seu e-mail"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                controller: passController,
                validator: (pass) {
                  if (pass == null || pass.isEmpty) {
                    return "A senha deve ser preenchida!";
                  }

                  if (pass.length < 6) {
                    return "A senha precisa ter pelo menos 6 caracteres";
                  }

                  if (pass.length > 5 && pass != "123456") {
                    return "Usuário ou senha inválidos!";
                  }

                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Insira sua senha",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    }
                  },
                  child: const Text("Entrar"))
            ],
          ),
        ),
      ),
    );
  }
}
