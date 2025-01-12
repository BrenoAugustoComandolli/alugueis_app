part of 'adicionar_dialog_widget.dart';

class _InputDescricaoWidget extends StatelessWidget {
  const _InputDescricaoWidget({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: [LengthLimitingTextInputFormatter(100)],
      decoration: const InputDecoration(labelText: MensagensAppConsts.labelDescricao),
      validator: _onValidar,
    );
  }

  String? _onValidar(value) {
    if (value == null || value.isEmpty) {
      return MensagensAppConsts.msgDescricaoObrigatorio;
    }
    return null;
  }
}
