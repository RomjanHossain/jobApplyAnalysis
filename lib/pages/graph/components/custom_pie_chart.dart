import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:joblookup/extension/string_ext.dart';
import 'package:joblookup/models/job_model.dart';
import 'package:joblookup/models/job_status.dart';
import 'package:joblookup/pages/components/indicator.dart';

class CustomPieChart extends StatefulWidget {
  const CustomPieChart({
    super.key,
    required this.statusCounts,
    required this.jobs,
  });

  final Map<String, int> statusCounts;
  final List<(int, JobModel)> jobs;

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  int touchedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: widget.statusCounts.entries.map((entry) {
                  return PieChartSectionData(
                    color: statusColor(
                        stringToJobStatus(entry.key.split('.').last)),
                    value: entry.value.toDouble(),
                    // show percentage in the title
                    title:
                        '${(entry.value / widget.jobs.length * 100).toStringAsFixed(0)}%',
                    radius: 70,
                    badgeWidget: Container(
                      // padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.successPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      width: 30,
                      child: Text(
                        entry.value.toString(),
                      ),
                    ),
                    badgePositionPercentageOffset: .98,
                    borderSide: BorderSide(
                      color: FluentTheme.of(context).scaffoldBackgroundColor,
                    ),
                  );
                }).toList(),
                borderData: FlBorderData(show: false),
                centerSpaceColor:
                    FluentTheme.of(context).scaffoldBackgroundColor,
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                titleSunbeamLayout: true,
              ),
              swapAnimationCurve: Curves.decelerate,
              swapAnimationDuration: const Duration(milliseconds: 800),
            ),
          ),
          NewWidget(
            statusCounts: widget.statusCounts,
          ),
        ],
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
    required this.statusCounts,
  });

  final Map<String, int> statusCounts;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (var entry in statusCounts.entries)
          Indicator(
            color: statusColor(stringToJobStatus(entry.key.split('.').last)),
            text: entry.key.split('.').last.fcapitalize(),
            isSquare: false,
          ),
      ],
    );
  }
}
