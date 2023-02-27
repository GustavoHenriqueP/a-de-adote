// ignore_for_file: public_member_api_docs, sort_constructors_first
class PetModel {
  final String nome;
  final String idadeAproximada;
  final String porte;
  final String raca;
  final bool castrado;
  final Map? vacinas;
  final String? descricao;
  
  PetModel({
    required this.nome,
    required this.idadeAproximada,
    required this.porte,
    required this.raca,
    required this.castrado,
    this.vacinas,
    this.descricao,
  });

  PetModel copyWith({
    String? nome,
    String? idadeAproximada,
    String? porte,
    String? raca,
    bool? castrado,
    Map? vacinas,
    String? descricao,
  }) {
    return PetModel(
      nome: nome ?? this.nome,
      idadeAproximada: idadeAproximada ?? this.idadeAproximada,
      porte: porte ?? this.porte,
      raca: raca ?? this.raca,
      castrado: castrado ?? this.castrado,
      vacinas: vacinas ?? this.vacinas,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'idadeAproximada': idadeAproximada,
      'porte': porte,
      'raca': raca,
      'castrado': castrado,
      'vacinas': vacinas,
      'descricao': descricao,
    };
  }

  factory PetModel.fromMap(Map<String, dynamic> map) {
    return PetModel(
      nome: map['nome'] as String,
      idadeAproximada: map['idadeAproximada'] as String,
      porte: map['porte'] as String,
      raca: map['raca'] as String,
      castrado: map['castrado'] as bool,
      vacinas: map['vacinas'] != null ? map['vacinas'] as Map<String,dynamic> : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }
  
  @override
  String toString() {
    return 'PetModel(nome: $nome, idadeAproximada: $idadeAproximada, porte: $porte, raca: $raca, castrado: $castrado, vacinas: $vacinas, descricao: $descricao)';
  }

}
