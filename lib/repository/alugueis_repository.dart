import 'dart:convert';

import 'package:alugueis/models/aluguel_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlugueisRepository {
  AlugueisRepository();

  static const String _alugueisKey = 'itens_aluguel';
  final List<AluguelModel> _alugueis = [];

  List<AluguelModel> get alugueis => _alugueis;

  Future<void> carregar() async {
    _alugueis.clear();

    final prefs = await SharedPreferences.getInstance();
    final alugueisStr = prefs.getString(_alugueisKey) ?? '[]';
    final List<dynamic> itensJson = jsonDecode(alugueisStr);

    _alugueis.addAll(itensJson.map((json) => AluguelModel.fromJson(json)).toList());
  }

  Future<void> add(AluguelModel novoItem) async {
    _alugueis.add(novoItem);
    await _salvar();
  }

  Future<void> deletar(AluguelModel item) async {
    _alugueis.remove(item);
    await _salvar();
  }

  Future<void> _salvar() async {
    final prefs = await SharedPreferences.getInstance();
    final alugueisStr = jsonEncode(_alugueis.map((item) => item.toJson()).toList());
    await prefs.setString(_alugueisKey, alugueisStr);
  }
}
