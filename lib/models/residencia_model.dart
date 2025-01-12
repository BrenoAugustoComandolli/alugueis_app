class ResidenciaModel {
  final String descricao;

  ResidenciaModel({
    required this.descricao,
  });

  factory ResidenciaModel.fromJson(Map<String, dynamic> json) {
    return ResidenciaModel(descricao: json['descricao'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'descricao': descricao};
  }
}
