import 'dart:convert';

import 'package:alugueis_app/models/residencia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResidenciasRepository {
  ResidenciasRepository();

  static const String _residenciasKey = 'itens_residencias';
  final List<ResidenciaModel> _residencias = [];

  List<ResidenciaModel> get residencias => _residencias;

  Future<void> carregar() async {
    _residencias.clear();

    final prefs = await SharedPreferences.getInstance();
    final alugueisStr = prefs.getString(_residenciasKey) ?? '[]';
    final List<dynamic> itensJson = jsonDecode(alugueisStr);

    _residencias.addAll(itensJson.map((json) => ResidenciaModel.fromJson(json)).toList());
  }

  Future<void> add(ResidenciaModel novoItem) async {
    _residencias.add(novoItem);
    await _salvar();
  }

  Future<void> deletar(ResidenciaModel item) async {
    _residencias.remove(item);
    await _salvar();
  }

  Future<void> _salvar() async {
    final prefs = await SharedPreferences.getInstance();
    final alugueisStr = jsonEncode(_residencias.map((item) => item.toJson()).toList());
    await prefs.setString(_residenciasKey, alugueisStr);
  }
}
