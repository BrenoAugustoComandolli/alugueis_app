enum AluguelType {
  renda("Renda"),
  despesa("Despesa");

  const AluguelType(this.value);

  final String value;

  static AluguelType valueOf(String tipo) {
    return AluguelType.values.firstWhere((e) => e.name == tipo);
  }

  static bool isRenda(AluguelType tipo) => tipo == AluguelType.renda;

  static bool isDespesa(AluguelType tipo) => tipo == AluguelType.despesa;
}
