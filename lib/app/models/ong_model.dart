// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OngModel {
  final String cnpj;
  final String email;
  final String fantasia;
  final String nome;
  final String telefone;
  final String cep;
  final String logradouro;
  final String numero;
  final String bairro;
  final String? complemento;
  final String municipio;
  final String uf;
  final String? informacoes;
  final Map? pix;

  OngModel({
    required this.cnpj,
    required this.email,
    required this.fantasia,
    required this.nome,
    required this.telefone,
    required this.cep,
    required this.logradouro,
    required this.numero,
    required this.bairro,
    this.complemento,
    required this.municipio,
    required this.uf,
    this.informacoes,
    this.pix,
  });

  OngModel copyWith({
    String? cnpj,
    String? email,
    String? fantasia,
    String? nome,
    String? telefone,
    String? cep,
    String? logradouro,
    String? numero,
    String? bairro,
    String? complemento,
    String? municipio,
    String? uf,
    String? informacoes,
    Map? pix,
  }) {
    return OngModel(
      cnpj: cnpj ?? this.cnpj,
      email: email ?? this.email,
      fantasia: fantasia ?? this.fantasia,
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      cep: cep ?? this.cep,
      logradouro: logradouro ?? this.logradouro,
      numero: numero ?? this.numero,
      bairro: bairro ?? this.bairro,
      complemento: complemento ?? this.complemento,
      municipio: municipio ?? this.municipio,
      uf: uf ?? this.uf,
      informacoes: informacoes ?? this.informacoes,
      pix: pix ?? this.pix,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cnpj': cnpj,
      'email': email,
      'fantasia': fantasia,
      'nome': nome,
      'telefone': telefone,
      'cep': cep,
      'logradouro': logradouro,
      'numero': numero,
      'bairro': bairro,
      'complemento': complemento,
      'municipio': municipio,
      'uf': uf,
      'informacoes': informacoes,
      'pix': pix,
    };
  }

  factory OngModel.fromMap(Map<String, dynamic> map) {
    return OngModel(
      cnpj: map['cnpj'] as String,
      email: map['email'] as String,
      fantasia: map['fantasia'] as String,
      nome: map['nome'] as String,
      telefone: map['telefone'] as String,
      cep: map['cep'] as String,
      logradouro: map['logradouro'] as String,
      numero: map['numero'] as String,
      bairro: map['bairro'] as String,
      complemento: map['complemento'] != null ? map['complemento'] as String : null,
      municipio: map['municipio'] as String,
      uf: map['uf'] as String,
      informacoes: map['informacoes'] != null ? map['informacoes'] as String : null,
      pix: map['pix'] != null ? map['pix'] as Map<String,dynamic> : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OngModel.fromJson(String source) => OngModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OngModel(cnpj: $cnpj, email: $email, fantasia: $fantasia, nome: $nome, telefone: $telefone, cep: $cep, logradouro: $logradouro, numero: $numero, bairro: $bairro, complemento: $complemento, municipio: $municipio, uf: $uf, informacoes: $informacoes, pix: $pix)';
  }
}
