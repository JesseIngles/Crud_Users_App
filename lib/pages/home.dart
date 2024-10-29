import 'package:flutter/material.dart';
import 'package:userapp/Dtos/userDto.dart';
import 'package:userapp/Models/resposta.model.dart';
import 'package:userapp/pages/userPage.dart';
import 'package:userapp/services/user.service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController userNameField = TextEditingController();
  TextEditingController userPassswordField = TextEditingController();
  TextEditingController userEmailField = TextEditingController();
  TextEditingController userOcupationField = TextEditingController();
  List<RespostaElement> usuarios = [];

  void _carregarUsers() async {
    final fetchedUsers = await UserService().fetchAllUsers();
    setState(() {
      usuarios = fetchedUsers;
    });
  }

  void _cadastrarUser() async {
    if (userNameField.text.isNotEmpty &&
        userPassswordField.text.isNotEmpty &&
        userEmailField.text.isNotEmpty &&
        userOcupationField.text.isNotEmpty) {
      
      bool success = await UserService().creatUser(UserDto(
        userName: userNameField.text,
        password: userPassswordField.text,
        email: userEmailField.text,
        ocupacao: userOcupationField.text,
      ));

      if (success) {
        Navigator.pop(context);
        _carregarUsers();
      } else {
        _mostrarErroCadastro();
      }
    } else {
      _mostrarErroCadastro();
    }
  }

  void _mostrarErroCadastro() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Não foi possível cadastrar o usuário')),
    );
  }

  void _addUser() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(child: Text('Cadastrar usuário')),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: _buildDialogContent(),
        actions: [
          GestureDetector(
            onTap: _cadastrarUser,
            child: const Text(
              'Salvar',
              style: TextStyle(color: Colors.green),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDialogContent() {
    return SizedBox(
      height: 250,
      width: 450,
      child: Column(
        children: [
          _buildTextField(controller: userNameField, hintText: 'Username'),
          _buildTextField(controller: userPassswordField, hintText: 'Password'),
          _buildTextField(controller: userEmailField, hintText: 'Email'),
          _buildTextField(controller: userOcupationField, hintText: 'Ocupação'),
        ],
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String hintText}) {
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _carregarUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.4),
        title: const Text('Gerenciador de usuários'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: usuarios.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPage(user: usuarios[index])),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 4,
                      blurRadius: 5,
                      color: Colors.grey.withOpacity(0.4),
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        usuarios[index].userName,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(usuarios[index].email),
                          Text(usuarios[index].ativo ? 'Online' : "Offline"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        tooltip: 'Adicionar user',
        child: const Icon(Icons.add),
      ),
    );
  }
}
