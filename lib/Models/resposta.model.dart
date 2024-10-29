class Resposta {
    List<RespostaElement> resposta;
    String mensagem;
    bool sucess;

    Resposta({
        required this.resposta,
        required this.mensagem,
        required this.sucess,
    });

    factory Resposta.fromJson(Map<String, dynamic> json) => Resposta(
        resposta: List<RespostaElement>.from(json["resposta"].map((x) => RespostaElement.fromJson(x))),
        mensagem: json["mensagem"],
        sucess: json["sucess"],
    );

    Map<String, dynamic> toJson() => {
        "resposta": List<dynamic>.from(resposta.map((x) => x.toJson())),
        "mensagem": mensagem,
        "sucess": sucess,
    };
}

class RespostaElement {
    int id;
    String userName;
    String email;
    String ocupacao;
    bool ativo;

    RespostaElement({
        required this.id,
        required this.userName,
        required this.email,
        required this.ocupacao,
        required this.ativo,
    });

    factory RespostaElement.fromJson(Map<String, dynamic> json) => RespostaElement(
        id: json["Id"],
        userName: json["UserName"],
        email: json["Email"],
        ocupacao: json["Ocupacao"],
        ativo: json["Ativo"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "UserName": userName,
        "Email": email,
        "Ocupacao": ocupacao,
        "Ativo": ativo,
    };
}
