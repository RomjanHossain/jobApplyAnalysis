
import 'package:fl_chart/fl_chart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:joblookup/extension/string_ext.dart';

class LineChatCustom extends StatelessWidget {
  const LineChatCustom({
    super.key,
    required this.jobCountsByMonth,
  });

  final Map<int, int> jobCountsByMonth;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.7,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: jobCountsByMonth.entries.map((entry) {
                return FlSpot(
                    entry.key.toDouble(), entry.value.toDouble());
              }).toList(),
              isCurved: true,
              barWidth: 4,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.blue.withOpacity(0.3),
                ],
                stops: const [0.5, 1],
              ),
            ),
          ],
          minX: 1,
          maxX: 12,
          maxY: jobCountsByMonth.values
                  .reduce((a, b) => a > b ? a : b)
                  .toDouble() +
              1,
          backgroundColor:
              FluentTheme.of(context).scaffoldBackgroundColor,
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (a, v) {
                  return Text(
                    a.fgetMonthName(),
                  );
                },
                interval: 1,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (a, v) {
                  return Text(
                    a.toInt().toString(),
                  );
                },
                // reservedSize: 42,
                interval: 1,
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
        ),
      ),
    );
  }
}
