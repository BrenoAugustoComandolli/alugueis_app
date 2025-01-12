part of 'resumo_page.dart';

class InputDataInicialWidget extends StatelessWidget {
  const InputDataInicialWidget({
    super.key,
    required this.dataInicial,
    required this.filtrarDados,
  });

  final DateTime dataInicial;
  final void Function(DateTime pickedDate) filtrarDados;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: const InputDecoration(labelText: MensagensAppConsts.labelDataInicial),
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: dataInicial,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null && pickedDate != dataInicial) {
          filtrarDados(pickedDate);
        }
      },
      controller: TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(dataInicial),
      ),
    );
  }
}
