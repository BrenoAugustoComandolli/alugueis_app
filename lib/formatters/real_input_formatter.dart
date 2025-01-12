import 'package:flutter/services.dart';

class RealInputFormatter extends TextInputFormatter {
  static const double _maxValue = 1000000.0;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final texto = _getSomenteNumeros(newValue);
    if (texto.isEmpty) return newValue.copyWith(text: '');

    final valorReais = _getValorMonetario(texto);
    if (valorReais > _maxValue) return oldValue;

    final novoTexto = _getValorFormatado(valorReais);

    return newValue.copyWith(
      text: novoTexto,
      selection: TextSelection.collapsed(
        offset: novoTexto.length,
      ),
    );
  }

  String _getSomenteNumeros(TextEditingValue newValue) => newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

  double _getValorMonetario(String texto) => double.parse(texto) / 100;

  String _getValorFormatado(double valorReais) => valorReais.toStringAsFixed(2).replaceAll('.', ',');
}
