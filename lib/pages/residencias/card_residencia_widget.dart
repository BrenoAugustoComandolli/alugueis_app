part of 'residencias_page.dart';

class CardResidenciaWidget extends StatelessWidget {
  const CardResidenciaWidget({
    super.key,
    required this.index,
    required this.repository,
    required this.onRemover,
  });

  final int index;
  final ResidenciasRepository repository;
  final void Function(int index) onRemover;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(repository.residencias[index].descricao),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () => onRemover(index),
        ),
      ),
    );
  }
}
