part of 'adicionar_dialog_widget.dart';

class _ComboTipoAluguelWidget extends StatefulWidget {
  const _ComboTipoAluguelWidget({
    required this.valorInicial,
    required this.onChanged,
  });

  final AluguelType valorInicial;
  final void Function(AluguelType novoValor) onChanged;

  @override
  State<_ComboTipoAluguelWidget> createState() => _ComboTipoAluguelWidgetState();
}

class _ComboTipoAluguelWidgetState extends State<_ComboTipoAluguelWidget> {
  AluguelType? valorSelecionado;

  @override
  void initState() {
    super.initState();
    valorSelecionado = widget.valorInicial;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<AluguelType>(
      isExpanded: true,
      value: valorSelecionado,
      hint: const Text(MensagensAppConsts.labelComboTipo),
      onChanged: (AluguelType? novoValor) {
        setState(() => valorSelecionado = novoValor);
        if (novoValor != null) widget.onChanged(novoValor);
      },
      items: AluguelType.values.map((AluguelType tipo) {
        return DropdownMenuItem<AluguelType>(
          value: tipo,
          child: Text(tipo.value),
        );
      }).toList(),
    );
  }
}
