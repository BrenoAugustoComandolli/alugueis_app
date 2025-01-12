part of 'resumo_page.dart';

class InputDataFinalWidget extends StatelessWidget {
  const InputDataFinalWidget({
    super.key,
    required this.dataFinal,
    required this.filtrarDados,
  });

  final DateTime dataFinal;
  final void Function(DateTime pickedDate) filtrarDados;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(labelText: MensagensAppConsts.labelDataFinal),
      readOnly: true,
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: dataFinal,
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null && pickedDate != dataFinal) {
          filtrarDados(pickedDate);
        }
      },
      controller: TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(dataFinal),
      ),
    );
  }
}
