part of 'adicionar_dialog_widget.dart';

class _InputValorWidget extends StatelessWidget {
  const _InputValorWidget({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(labelText: MensagensAppConsts.labelTextValor),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        RealInputFormatter(),
      ],
      validator: _onValidar,
    );
  }

  String? _onValidar(value) {
    if (value == null || value.isEmpty) {
      return MensagensAppConsts.msgValorObrigatorio;
    }

    final valorConvertido = double.tryParse(value.replaceAll(',', '.'));
    if (valorConvertido == null || valorConvertido < 0) {
      return MensagensAppConsts.msgValorInvalido;
    }
    return null;
  }
}
