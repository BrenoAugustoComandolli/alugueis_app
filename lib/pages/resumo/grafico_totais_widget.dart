part of 'resumo_page.dart';

class GraficoTotaisWidget extends StatelessWidget {
  const GraficoTotaisWidget({
    super.key,
    required this.totalRenda,
    required this.totalDespesas,
    required this.totalLucro,
  });

  final double totalRenda;
  final double totalDespesas;
  final double totalLucro;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceBetween,
              barTouchData: BarTouchData(enabled: false),
              titlesData: const FlTitlesData(show: true),
              borderData: FlBorderData(show: true),
              gridData: const FlGridData(show: true),
              backgroundColor: Colors.grey[200],
              barGroups: [
                BarChartGroupData(x: 0, barRods: [BarChartRodData(color: Colors.green, width: 30, toY: totalRenda)]),
                BarChartGroupData(x: 1, barRods: [BarChartRodData(color: Colors.red, width: 30, toY: totalDespesas)]),
                BarChartGroupData(x: 2, barRods: [BarChartRodData(color: Colors.blue, width: 30, toY: totalLucro)]),
              ],
            ),
          ),
        ),
        const AreaLegandasWidget(),
      ],
    );
  }
}

class AreaLegandasWidget extends StatelessWidget {
  const AreaLegandasWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LegendaWidget(color: Colors.green, label: MensagensAppConsts.labelRendas),
        SizedBox(width: 10),
        _LegendaWidget(color: Colors.red, label: MensagensAppConsts.labelDespesas),
        SizedBox(width: 10),
        _LegendaWidget(color: Colors.blue, label: MensagensAppConsts.labelLucros),
      ],
    );
  }
}

class _LegendaWidget extends StatelessWidget {
  const _LegendaWidget({
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}
