part of 'adicionar_dialog_widget.dart';

class _InputDataOperacaoWidget extends StatelessWidget {
  const _InputDataOperacaoWidget({
    required this.dataInicial,
    required this.onChanged,
  });

  final DateTime dataInicial;
  final void Function(DateTime pickedDate) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: const InputDecoration(labelText: MensagensAppConsts.labelDataOperacao),
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: dataInicial,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null && pickedDate != dataInicial) {
          onChanged(pickedDate);
        }
      },
      controller: TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(dataInicial),
      ),
    );
  }
}
