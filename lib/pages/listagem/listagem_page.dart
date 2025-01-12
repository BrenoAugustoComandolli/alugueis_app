import 'package:alugueis/consts/mensagens_app_consts.dart';
import 'package:alugueis/models/aluguel_model.dart';
import 'package:alugueis/models/aluguel_type.dart';
import 'package:alugueis/pages/listagem/adicionar_dialog_widget.dart';
import 'package:alugueis/repository/alugueis_repository.dart';
import 'package:flutter/material.dart';

class ListagemPage extends StatefulWidget {
  const ListagemPage({super.key});

  @override
  State<ListagemPage> createState() => _ListagemPageState();
}

class _ListagemPageState extends State<ListagemPage> {
  final AlugueisRepository repository = AlugueisRepository();
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        return Scaffold(
          body: repository.alugueis.isEmpty
              ? const _NenhumAluguelWidget()
              : _ListaAlugueisWidget(
                  alugueis: repository.alugueis,
                  onDelete: _onDelete,
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AdicionarDialogWidget(
                onSalvar: _onSalvar,
              ),
            ),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _onSalvar(AluguelModel aluguel) {
    repository.add(aluguel);
    Navigator.of(context).pop();
    setState(() {});
  }

  Future<void> _onDelete(AluguelModel aluguel) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(MensagensAppConsts.labelConfirmaExclusao),
        content: const Text(MensagensAppConsts.msgConfirmacaoExclusao),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(MensagensAppConsts.labelBtnCancelar),
          ),
          TextButton(
            onPressed: () {
              repository.deletar(aluguel);
              Navigator.of(context).pop();
              setState(() {});
            },
            child: const Text(MensagensAppConsts.labelBtnExcluir),
          ),
        ],
      ),
    );
  }
}

class _NenhumAluguelWidget extends StatelessWidget {
  const _NenhumAluguelWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        MensagensAppConsts.labelNenhumAluguel,
      ),
    );
  }
}

class _ListaAlugueisWidget extends StatelessWidget {
  const _ListaAlugueisWidget({
    required this.alugueis,
    required this.onDelete,
  });

  final List<AluguelModel> alugueis;
  final void Function(AluguelModel aluguel) onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) => const Divider(),
      itemCount: alugueis.length,
      itemBuilder: (context, index) {
        final aluguel = alugueis[index];

        return ListTile(
          title: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: [
              _DescricaoWidget(aluguel: aluguel),
              _ValorWidget(aluguel: aluguel),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ResidenciaWidget(aluguel: aluguel),
              _DataRegistroWidget(aluguel: aluguel),
            ],
          ),
          trailing: _IconeExclusaoWidget(
            aluguel: aluguel,
            onDelete: onDelete,
          ),
        );
      },
    );
  }
}

class _DescricaoWidget extends StatelessWidget {
  const _DescricaoWidget({required this.aluguel});

  final AluguelModel aluguel;

  @override
  Widget build(BuildContext context) {
    return Text(
      aluguel.descricao,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _ValorWidget extends StatelessWidget {
  const _ValorWidget({required this.aluguel});

  final AluguelModel aluguel;

  @override
  Widget build(BuildContext context) {
    return Text(
      aluguel.valorFormatado,
      style: TextStyle(
        color: AluguelType.isRenda(aluguel.tipo) ? Colors.green : Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _DataRegistroWidget extends StatelessWidget {
  const _DataRegistroWidget({required this.aluguel});

  final AluguelModel aluguel;

  @override
  Widget build(BuildContext context) {
    return Text('${MensagensAppConsts.labelDataRegistro} ${aluguel.dataFormatada}');
  }
}

class _ResidenciaWidget extends StatelessWidget {
  const _ResidenciaWidget({required this.aluguel});

  final AluguelModel aluguel;

  @override
  Widget build(BuildContext context) {
    return Text('${MensagensAppConsts.labelResidencia} ${aluguel.residencia.descricao}');
  }
}

class _IconeExclusaoWidget extends StatelessWidget {
  const _IconeExclusaoWidget({
    required this.aluguel,
    required this.onDelete,
  });

  final AluguelModel aluguel;
  final void Function(AluguelModel aluguel) onDelete;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: () => onDelete(aluguel),
    );
  }
}
