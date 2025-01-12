import 'package:alugueis/models/aluguel_type.dart';
import 'package:alugueis/models/residencia_model.dart';
import 'package:intl/intl.dart';

class AluguelModel {
  final String descricao;
  final double valor;
  final AluguelType tipo;
  final ResidenciaModel residencia;
  final DateTime data;

  AluguelModel({
    required this.descricao,
    required this.valor,
    required this.tipo,
    required this.residencia,
    required this.data,
  });

  factory AluguelModel.fromJson(Map<String, dynamic> json) {
    return AluguelModel(
      descricao: json['descricao'] as String,
      valor: (json['valor'] as num).toDouble(),
      tipo: AluguelType.valueOf(json['tipo'] as String),
      residencia: ResidenciaModel.fromJson(json['residencia'] as Map<String, dynamic>),
      data: DateTime.parse(json['data'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'descricao': descricao,
      'valor': valor,
      'tipo': tipo.name,
      'residencia': residencia.toJson(),
      'data': data.toIso8601String(),
    };
  }

  String get valorFormatado {
    return 'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  String get dataFormatada {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(data);
  }

  DateTime get dataHorasZeradas {
    final dataFormatada = DateFormat('yyyy-MM-dd').format(data);
    return DateTime.parse(dataFormatada);
  }
}
