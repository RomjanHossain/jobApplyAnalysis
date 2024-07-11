import 'package:fluent_ui/fluent_ui.dart';
import 'package:joblookup/models/job_model.dart';
import 'package:joblookup/models/job_status.dart';
import 'package:joblookup/pages/graph/components/custom_line_chart.dart';
import 'package:joblookup/pages/graph/components/custom_pie_chart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as p;

class ViewTheDatabaseGraph extends StatefulWidget {
  const ViewTheDatabaseGraph({super.key});

  @override
  State<ViewTheDatabaseGraph> createState() => _ViewTheDatabaseGraphState();
}

class _ViewTheDatabaseGraphState extends State<ViewTheDatabaseGraph> {
  List<(int, JobModel)> jobs = [];
  void initTheDB() async {
    var databaseFactory = databaseFactoryFfi;
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    String dbPath = p.join(appDocumentsDir.path, "jobDatabase", "job.db");
    final db = await databaseFactory.openDatabase(dbPath);
    final List<Map<String, dynamic>> maps = await db.query('jobs');
    jobs = List.generate(maps.length, (i) {
      return (
        maps[i]['id'],
        JobModel(
          position: maps[i]['position'],
          jobPost: maps[i]['jobPost'],
          salary: maps[i]['salary'],
          description: maps[i]['description'],
          companyName: maps[i]['companyName'],
          address: maps[i]['address'],
          website: maps[i]['website'],
          business: maps[i]['business'],
          appliedDate: DateTime.parse(
            maps[i]['appliedDate'],
          ),
          status: maps[i]['status'],
        )
      );
    });
    for (var job in jobs) {
      final month = job.$2.appliedDate.month;
      if (jobCountsByMonth.containsKey(month)) {
        jobCountsByMonth[month] = jobCountsByMonth[month]! + 1;
      } else {
        jobCountsByMonth[month] = 1;
      }
    }
    for (var job in jobs) {
      if (statusCounts.containsKey(job.$2.status)) {
        statusCounts[job.$2.status ?? JobStatus.applied.toString()] =
            statusCounts[job.$2.status]! + 1;
      } else {
        statusCounts[job.$2.status ?? JobStatus.applied.toString()] = 1;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initTheDB();
  }

// Pre-process jobs data for efficiency
  Map<int, int> jobCountsByMonth = {};
  // status and its value
  Map<String, int> statusCounts = {};
  @override
  Widget build(BuildContext context) {
    // print(jobCountsByMonth);
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView(
        children: [
          Text(
            "Applied Jobs Line Graph",
            style: FluentTheme.of(context).typography.title,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: LineChatCustom(jobCountsByMonth: jobCountsByMonth),
          ),
          Text(
            "Status Pie Chart",
            textAlign: TextAlign.center,
            style: FluentTheme.of(context).typography.title,
          ),
          // show the pie chart (statusCounts)
          CustomPieChart(statusCounts: statusCounts, jobs: jobs),
        ],
      ),
    );
  }
}
