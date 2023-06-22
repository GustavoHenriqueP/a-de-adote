class PetModel {
  final String? id;
  final String? ongId;
  final String? ongNome;
  final String? nome;
  final String? idMicrochip;
  final String idadeAproximada;
  final String porte;
  final String especie;
  final String sexo;
  final bool castrado;
  String? fotoUrl;
  final Map? vacinas;
  final String? descricao;

  PetModel({
    this.id,
    this.ongId,
    this.ongNome,
    this.nome,
    this.idMicrochip,
    required this.idadeAproximada,
    required this.porte,
    required this.especie,
    required this.sexo,
    required this.castrado,
    this.fotoUrl,
    this.vacinas,
    this.descricao,
  });

  PetModel copyWith({
    String? id,
    String? ongId,
    String? ongNome,
    String? nome,
    String? idMicrochip,
    String? idadeAproximada,
    String? porte,
    String? especie,
    String? sexo,
    bool? castrado,
    String? fotoUrl,
    Map? vacinas,
    String? descricao,
  }) {
    return PetModel(
      id: id ?? this.id,
      ongId: ongId ?? this.ongId,
      ongNome: ongNome ?? this.ongNome,
      nome: nome ?? this.nome,
      idMicrochip: nome ?? this.idMicrochip,
      idadeAproximada: idadeAproximada ?? this.idadeAproximada,
      porte: porte ?? this.porte,
      especie: especie ?? this.especie,
      sexo: sexo ?? this.sexo,
      castrado: castrado ?? this.castrado,
      fotoUrl: fotoUrl ?? this.fotoUrl,
      vacinas: vacinas ?? this.vacinas,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ongId': ongId,
      'ongNome': ongNome,
      'nome': nome,
      'idMicrochip': idMicrochip,
      'idadeAproximada': idadeAproximada,
      'porte': porte,
      'especie': especie,
      'sexo': sexo,
      'castrado': castrado,
      'fotoUrl': fotoUrl,
      'vacinas': vacinas,
      'descricao': descricao,
    };
  }

  factory PetModel.fromMap(Map<String, dynamic> map) {
    return PetModel(
      id: map['id'] != null ? map['id'] as String : null,
      ongId: map['ongId'] != null ? map['ongId'] as String : null,
      ongNome: map['ongNome'] != null ? map['ongNome'] as String : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      idMicrochip:
          map['idMicrochip'] != null ? map['idMicrochip'] as String : null,
      idadeAproximada: map['idadeAproximada'] as String,
      porte: map['porte'] as String,
      especie: map['especie'] as String,
      sexo: map['sexo'] as String,
      castrado: map['castrado'] as bool,
      fotoUrl: map['fotoUrl'] != null ? map['fotoUrl'] as String : null,
      vacinas: map['vacinas'] != null
          ? map['vacinas'] as Map<String, dynamic>
          : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }

  @override
  String toString() {
    return 'PetModel(id: $id, ongId: $ongId, ongNome: $ongNome, nome: $nome, nome: $idMicrochip, idadeAproximada: $idadeAproximada, porte: $porte, especie: $especie, sexo: $sexo, castrado: $castrado, fotoUrl: $fotoUrl, vacinas: $vacinas, descricao: $descricao)';
  }
}
