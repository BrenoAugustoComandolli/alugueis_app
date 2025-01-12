import 'package:alugueis/consts/mensagens_app_consts.dart';
import 'package:alugueis/models/aluguel_model.dart';
import 'package:alugueis/models/aluguel_type.dart';
import 'package:alugueis/models/residencia_model.dart';
import 'package:alugueis/repository/alugueis_repository.dart';
import 'package:alugueis/widgets/combo_residencia_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'grafico_totais_widget.dart';
part 'input_data_final_widget.dart';
part 'input_data_inicial_widget.dart';

class ResumoPage extends StatefulWidget {
  const ResumoPage({super.key});

  @override
  State<ResumoPage> createState() => _ResumoPageState();
}

class _ResumoPageState extends State<ResumoPage> {
  final AlugueisRepository repository = AlugueisRepository();
  late final Future onLoad;
  ResidenciaModel? residencia;

  @override
  void initState() {
    super.initState();

    onLoad = repository.carregar().then((_) => _filtrarDadosPorData());
  }

  DateTime dataInicial = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  DateTime dataFinal = DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  double totalRenda = 0;
  double totalDespesas = 0;
  double totalLucro = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: onLoad,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InputDataInicialWidget(
                  dataInicial: dataInicial,
                  filtrarDados: (pickedDate) {
                    setState(() => dataInicial = pickedDate);
                    _filtrarDadosPorData();
                  },
                ),
                const SizedBox(height: 10),
                InputDataFinalWidget(
                  dataFinal: dataFinal,
                  filtrarDados: (pickedDate) {
                    setState(() => dataFinal = pickedDate);
                    _filtrarDadosPorData();
                  },
                ),
                const SizedBox(height: 10),
                ComboResidenciaWidget(
                  onChanged: (novoValor) {
                    setState(() => residencia = novoValor);
                    _filtrarDadosPorData();
                  },
                ),
                const SizedBox(height: 20),
                if (_isDataValida()) ...[
                  Text('${MensagensAppConsts.labelTotalRenda} ${totalRenda.toStringAsFixed(2)}'),
                  Text('${MensagensAppConsts.labelTotalDespesas} ${totalDespesas.toStringAsFixed(2)}'),
                  Text('${MensagensAppConsts.labelTotalLucro} ${totalLucro.toStringAsFixed(2)}'),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GraficoTotaisWidget(
                      totalRenda: totalRenda,
                      totalDespesas: totalDespesas,
                      totalLucro: totalLucro,
                    ),
                  ),
                ] else ...[
                  const Text(MensagensAppConsts.msgDataFinalMaiorInicial),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  bool _isDataValida() {
    return dataInicial.isBefore(dataFinal) || dataInicial.isAtSameMomentAs(dataFinal);
  }

  void _filtrarDadosPorData() {
    if (_isDataValida()) {
      totalRenda = 0;
      totalDespesas = 0;
      totalLucro = 0;

      for (var umAluguel in getAlugueisDaResidencia()) {
        if (_isDataAluguelEntreFitros(umAluguel)) {
          switch (umAluguel.tipo) {
            case AluguelType.renda:
              totalRenda += umAluguel.valor;
              break;
            case AluguelType.despesa:
              totalDespesas += umAluguel.valor;
              break;
          }
        }
      }
      totalLucro = totalRenda - totalDespesas;
    }
  }

  Iterable<AluguelModel> getAlugueisDaResidencia() {
    return repository.alugueis.where(
      (umAluguel) => residencia == null || umAluguel.residencia.descricao == residencia!.descricao,
    );
  }

  bool _isDataAluguelEntreFitros(AluguelModel umAluguel) =>
      (umAluguel.dataHorasZeradas.isAfter(dataInicial) || umAluguel.dataHorasZeradas.isAtSameMomentAs(dataInicial)) &&
      (umAluguel.dataHorasZeradas.isBefore(dataFinal) || umAluguel.dataHorasZeradas.isAtSameMomentAs(dataFinal));
}
