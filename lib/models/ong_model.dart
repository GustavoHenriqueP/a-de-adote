import 'dart:convert';

class OngModel {
  final String cnpj;
  final String email;
  final String nomeFantasia;
  final String razaoSocial;
  final String telefone;
  final String cep;
  final String logradouro;
  final String numero;
  final String bairro;
  final String? complemento;
  final String cidade;
  final String uf;
  final String? informacoes;
  final Map? pix;

  OngModel({
    required this.cnpj,
    required this.email,
    required this.nomeFantasia,
    required this.razaoSocial,
    required this.telefone,
    required this.cep,
    required this.logradouro,
    required this.numero,
    required this.bairro,
    this.complemento,
    required this.cidade,
    required this.uf,
    this.informacoes,
    this.pix,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cnpj': cnpj,
      'email': email,
      'nomeFantasia': nomeFantasia,
      'razaoSocial': razaoSocial,
      'telefone': telefone,
      'cep': cep,
      'logradouro': logradouro,
      'numero': numero,
      'bairro': bairro,
      'complemento': complemento,
      'cidade': cidade,
      'uf': uf,
      'informacoes': informacoes,
      'pix': pix,
    };
  }

  factory OngModel.fromMap(Map<String, dynamic> map) {
    return OngModel(
      cnpj: map['cnpj'] as String,
      email: map['email'] as String,
      nomeFantasia: map['nomeFantasia'] as String,
      razaoSocial: map['razaoSocial'] as String,
      telefone: map['telefone'] as String,
      cep: map['cep'] as String,
      logradouro: map['logradouro'] as String,
      numero: map['numero'] as String,
      bairro: map['bairro'] as String,
      complemento: map['complemento'] != null ? map['complemento'] as String : null,
      cidade: map['cidade'] as String,
      uf: map['uf'] as String,
      informacoes: map['informacoes'] != null ? map['informacoes'] as String : null,
      pix: map['pix'] != null ? map['pix'] as Map<String,dynamic> : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OngModel.fromJson(String source) => OngModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
