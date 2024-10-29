import 'package:flutter/material.dart';
import 'package:userapp/Models/resposta.model.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.user});
  final RespostaElement user;
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.userName),
        centerTitle: true,
        backgroundColor: Colors.grey.withOpacity(0.5),
        actions: const [
          Icon(Icons.person),
          SizedBox(width: 15,)
        ],
      ),
      body: const Column(children: [

      ],),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.amber[400],borderRadius: BorderRadius.circular(10)), child: Text('Editar')),
            const SizedBox(width: 20,),
            Container(padding: const EdgeInsets.all(15),decoration: BoxDecoration(color: Colors.red[800], borderRadius: BorderRadius.circular(10)), child: Text('Deletar'))
        ],),
      ),
    );
  }
}
