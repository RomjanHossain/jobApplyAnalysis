import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:intl/intl.dart';
import 'package:joblookup/models/job_model.dart';
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ViewTheDatabase extends StatefulWidget {
  const ViewTheDatabase({super.key});

  @override
  State<ViewTheDatabase> createState() => _ViewTheDatabaseState();
}

class _ViewTheDatabaseState extends State<ViewTheDatabase> {
  List<JobModel> jobs = [];
  void initTheDB() async {
    var databaseFactory = databaseFactoryFfi;
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    String dbPath = p.join(appDocumentsDir.path, "jobDatabase", "job.db");
    final db = await databaseFactory.openDatabase(dbPath);
    final List<Map<String, dynamic>> maps = await db.query('jobs');
    print("THe length of the maps is ${maps.length}");
    jobs = List.generate(maps.length, (i) {
      return JobModel(
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
      );
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    print("initState for ViewTheDatabase");
    initTheDB();
  }

  @override
  Widget build(BuildContext context) {
    return m.DataTable(
        columns: const [
          m.DataColumn(label: Text('Position')),
          m.DataColumn(label: Text('Company')),
          m.DataColumn(label: Text('Salary')),
          m.DataColumn(label: Text('Address')),
          m.DataColumn(label: Text('Applied Date')),
        ],
        rows: jobs.map((job) {
          return m.DataRow(
            onLongPress: () async {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return ContentDialog(
                      title: const Text('Job Details'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Position: ${job.position}"),
                          Text("Job Post: ${job.jobPost}"),
                          Text("Salary: ${job.salary}"),
                          Text("Description: ${job.description}"),
                          Text("Company Name: ${job.companyName}"),
                          Text("Address: ${job.address}"),
                          Text("Website: ${job.website}"),
                          Text("Business: ${job.business}"),
                          Text(
                              "Applied Date: ${DateFormat.yMMMd().format(job.appliedDate)}"),
                        ],
                      ),
                      actions: [
                        Button(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  });
            },
            cells: [
              m.DataCell(Text(job.position)),
              m.DataCell(Text(job.companyName)),
              m.DataCell(Text(job.salary)),
              m.DataCell(Text(job.address)),
              m.DataCell(Text(DateFormat.yMMMd().format(job.appliedDate))),
            ],
          );
        }).toList());
  }
}
