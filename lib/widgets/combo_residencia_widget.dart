import 'package:alugueis_app/consts/mensagens_app_consts.dart';
import 'package:alugueis_app/models/residencia_model.dart';
import 'package:alugueis_app/repository/residencias_repository.dart';
import 'package:flutter/material.dart';

class ComboResidenciaWidget extends StatefulWidget {
  const ComboResidenciaWidget({
    super.key,
    required this.onChanged,
  });

  final void Function(ResidenciaModel novoValor) onChanged;

  @override
  State<ComboResidenciaWidget> createState() => ComboResidenciaWidgetState();
}

class ComboResidenciaWidgetState extends State<ComboResidenciaWidget> {
  final ResidenciasRepository repository = ResidenciasRepository();
  ResidenciaModel? valorSelecionado;
  late final Future onLoad;

  @override
  void initState() {
    super.initState();
    onLoad = repository.carregar();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: onLoad,
      builder: (context, snapshot) {
        return DropdownButton<ResidenciaModel>(
          isExpanded: true,
          value: valorSelecionado,
          hint: const Text(MensagensAppConsts.labelComboResidencia),
          onChanged: (ResidenciaModel? novoValor) {
            setState(() => valorSelecionado = novoValor);
            if (novoValor != null) widget.onChanged(novoValor);
          },
          items: repository.residencias.map((ResidenciaModel model) {
            return DropdownMenuItem<ResidenciaModel>(
              value: model,
              child: Text(model.descricao),
            );
          }).toList(),
        );
      },
    );
  }
}
