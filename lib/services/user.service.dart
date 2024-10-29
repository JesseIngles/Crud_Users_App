import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:userapp/Dtos/updateUserDto.dart';
import 'package:userapp/Dtos/userDto.dart';
import 'package:userapp/Models/resposta.model.dart';

class UserService {
  Future<List<RespostaElement>> fetchAllUsers() async {
    final url = Uri.parse('http://localhost:3000/UserController/todos');

    try {
      // Enviando a requisição GET
      final response = await http.get(url, headers: {'accept': '*/*'});

      if (response.statusCode == 200) {
        // Decodificando o corpo da resposta
        var jsonResponse = jsonDecode(response.body);

        return Resposta.fromJson(jsonResponse).resposta;
      } else {
        throw Exception(
            'Erro ao buscar usuários. Código: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
      return [];
    }
  }

  Future<bool> creatUser(UserDto user) async {
    final url = Uri.parse('http://localhost:3000/UserController/cadastrar');

    try {
      final response =
          await http.post(url, headers: {'accept': '*/*'}, body: user.toJson());

      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
        return Resposta.fromJson(jsonResponse).sucess;
      } else {
        throw Exception(
            'Erro ao criar usuário. Código: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro: $e');
      return false;
    }
  }

  Future<bool> atualizarUser(UpdateUserDto user) async {
    final url = Uri.parse('http://localhost:3000/UserController/atualizar');

    try {
      final response = await http.put(url, body: user.toJson());

      if (response.statusCode == 201) {
        var jsonDecoded = jsonDecode(response.body);
        return Resposta.fromJson(jsonDecoded).sucess;
      } else {
        throw Exception(
            'Erro ao atualizar usuário. Código ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deletarUser(int id) async {
    final url = Uri.parse('http://localhost:3000/UserController/eliminar');

    try {
      var userId = {'userId': id};
      final response = await http.delete(url, body: userId);

      if (response.statusCode == 201) {
        var jsonDecoded = jsonDecode(response.body);
        return Resposta.fromJson(jsonDecoded).sucess;
      } else {
        throw Exception(
            'Erro ao deletar usuário. Código ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
