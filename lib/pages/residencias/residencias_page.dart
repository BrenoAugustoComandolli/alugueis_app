import 'package:alugueis/consts/mensagens_app_consts.dart';
import 'package:alugueis/models/residencia_model.dart';
import 'package:alugueis/repository/residencias_repository.dart';
import 'package:flutter/material.dart';

part 'card_residencia_widget.dart';

class ResidenciasPage extends StatefulWidget {
  const ResidenciasPage({super.key});

  @override
  State<ResidenciasPage> createState() => _ResidenciasPageState();
}

class _ResidenciasPageState extends State<ResidenciasPage> {
  final TextEditingController _controller = TextEditingController();
  final ResidenciasRepository repository = ResidenciasRepository();
  late final Future onLoad;

  @override
  void initState() {
    super.initState();

    onLoad = repository.carregar();
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  void _adicionarResidencia() {
    if (repository.residencias.where((residencia) => residencia.descricao == _controller.text).isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => const _AlertaResidenciaJaExistenteWidget(),
      );
    } else if (_controller.text.isNotEmpty) {
      repository.add(ResidenciaModel(
        descricao: _controller.text,
      ));
      setState(() => _controller.clear());
    }
  }

  void _removerResidencia(int index) {
    repository.deletar(repository.residencias[index]);
    setState(() {});
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
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _EdicaoResidenciaWidget(
                  controller: _controller,
                  onAdicionar: _adicionarResidencia,
                ),
                const SizedBox(height: 16),
                _ListagemResidenciasWidget(
                  repository: repository,
                  onRemover: _removerResidencia,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EdicaoResidenciaWidget extends StatelessWidget {
  const _EdicaoResidenciaWidget({
    required this.controller,
    required this.onAdicionar,
  });

  final TextEditingController controller;
  final VoidCallback onAdicionar;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: MensagensAppConsts.labelNovaResidencia,
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: onAdicionar,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}

class _ListagemResidenciasWidget extends StatelessWidget {
  const _ListagemResidenciasWidget({
    required this.repository,
    required this.onRemover,
  });

  final ResidenciasRepository repository;
  final void Function(int index) onRemover;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: repository.residencias.length,
        itemBuilder: (context, index) {
          return CardResidenciaWidget(
            index: index,
            repository: repository,
            onRemover: onRemover,
          );
        },
      ),
    );
  }
}

class _AlertaResidenciaJaExistenteWidget extends StatelessWidget {
  const _AlertaResidenciaJaExistenteWidget();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Row(
        children: [
          Icon(Icons.error, color: Colors.red),
          SizedBox(width: 10),
          Text(
            style: TextStyle(color: Colors.red),
            MensagensAppConsts.msgResidenciaJaExistente,
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
