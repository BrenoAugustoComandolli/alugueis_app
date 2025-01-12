import 'package:alugueis/consts/mensagens_app_consts.dart';
import 'package:alugueis/formatters/real_input_formatter.dart';
import 'package:alugueis/models/aluguel_model.dart';
import 'package:alugueis/models/aluguel_type.dart';
import 'package:alugueis/models/residencia_model.dart';
import 'package:alugueis/widgets/combo_residencia_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

part 'combo_tipo_aluguel_widget.dart';
part 'input_data_operacao_widget.dart';
part 'input_descricao_widget.dart';
part 'input_valor_widget.dart';

class AdicionarDialogWidget extends StatefulWidget {
  const AdicionarDialogWidget({
    super.key,
    required this.onSalvar,
  });

  final void Function(AluguelModel aluguel) onSalvar;

  @override
  State<AdicionarDialogWidget> createState() => _AdicionarDialogWidgetState();
}

class _AdicionarDialogWidgetState extends State<AdicionarDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();
  AluguelType _tipoAluguel = AluguelType.renda;
  DateTime _dataOperacao = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  ResidenciaModel? _residenciaModel;

  @override
  void dispose() {
    super.dispose();

    _descricaoController.dispose();
    _valorController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(MensagensAppConsts.labelAdicionarNovo),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _InputDescricaoWidget(controller: _descricaoController),
            _InputValorWidget(controller: _valorController),
            _ComboTipoAluguelWidget(
              valorInicial: _tipoAluguel,
              onChanged: (novoValor) {
                setState(() => _tipoAluguel = novoValor);
              },
            ),
            ComboResidenciaWidget(
              onChanged: (novoValor) {
                setState(() => _residenciaModel = novoValor);
              },
            ),
            _InputDataOperacaoWidget(
              dataInicial: _dataOperacao,
              onChanged: (pickedDate) {
                setState(() => _dataOperacao = pickedDate);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(MensagensAppConsts.labelBtnCancelar),
        ),
        ElevatedButton(
          onPressed: () => _onSalvar(context),
          child: const Text(MensagensAppConsts.labelBtnSalvar),
        ),
      ],
    );
  }

  void _onSalvar(BuildContext context) {
    if (_residenciaModel == null) {
      showDialog(
        context: context,
        builder: (context) => const _AlertaResidenciaObrigatoriaWidget(),
      );
    } else if (_formKey.currentState!.validate()) {
      widget.onSalvar(
        AluguelModel(
          descricao: _descricaoController.text,
          valor: double.parse(_valorController.text.replaceAll(',', '.')),
          tipo: _tipoAluguel,
          residencia: _residenciaModel!,
          data: _dataOperacao,
        ),
      );
    }
  }
}

class _AlertaResidenciaObrigatoriaWidget extends StatelessWidget {
  const _AlertaResidenciaObrigatoriaWidget();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Row(
        children: [
          Icon(Icons.error, color: Colors.red),
          SizedBox(width: 10),
          Text(
            style: TextStyle(color: Colors.red),
            MensagensAppConsts.msgResidenciaObrigatoria,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(MensagensAppConsts.labelBtnOk),
        ),
      ],
    );
  }
}
