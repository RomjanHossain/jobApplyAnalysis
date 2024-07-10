import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:intl/intl.dart';
import 'package:joblookup/models/job_model.dart';
import 'package:joblookup/models/job_status.dart';
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ViewTheDatabase extends StatefulWidget {
  const ViewTheDatabase({super.key});

  @override
  State<ViewTheDatabase> createState() => _ViewTheDatabaseState();
}

class _ViewTheDatabaseState extends State<ViewTheDatabase> {
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
    setState(() {});
  }

  void updateStatus(String status, int id) async {
    var databaseFactory = databaseFactoryFfi;
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    String dbPath = p.join(appDocumentsDir.path, "jobDatabase", "job.db");
    final db = await databaseFactory.openDatabase(dbPath);
    await db.update(
      'jobs',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
    initTheDB();
  }

  @override
  void initState() {
    super.initState();
    initTheDB();
  }

  @override
  Widget build(BuildContext context) {
    return m.Material(
      child: m.DataTable(
          columns: const [
            m.DataColumn(label: Text('Position')),
            m.DataColumn(label: Text('Company')),
            m.DataColumn(label: Text('Salary')),
            m.DataColumn(label: Text('Address')),
            m.DataColumn(label: Text('Applied Date')),
            m.DataColumn(label: Text('Status')),
          ],
          rows: jobs.map((job) {
            return m.DataRow(
              onLongPress: () async {
                await showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return ContentDialog(
                        title: const Text('Job Details'),
                        content: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Position: ${job.$2.position}"),
                                Text("Job Post: ${job.$2.jobPost}"),
                                Text("Salary: ${job.$2.salary}"),
                                Text("Description: ${job.$2.description}"),
                                Text("Company Name: ${job.$2.companyName}"),
                                Text("Address: ${job.$2.address}"),
                                Text("Website: ${job.$2.website}"),
                                Text("Business: ${job.$2.business}"),
                                Text(
                                    "Applied Date: ${DateFormat.yMMMd().format(job.$2.appliedDate)}"),
                                Text("Status: ${job.$2.status}"),
                              ],
                            ),
                          ),
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
                m.DataCell(Text(job.$2.position)),
                m.DataCell(Text(job.$2.companyName)),
                m.DataCell(Text(job.$2.salary)),
                m.DataCell(Text(job.$2.address)),
                m.DataCell(Text(DateFormat.yMMMd().format(job.$2.appliedDate))),
                m.DataCell(DropDownButton(
                  title: Text(job.$2.status?.split('.').last.fcapitalize() ??
                      'Applied'),
                  items: [
                    if (job.$2.status != JobStatus.applied.toString())
                      MenuFlyoutItem(
                        text: const Text('Applied'),
                        onPressed: () {
                          // update the status
                          updateStatus(JobStatus.applied.toString(), job.$1);
                        },
                      ),
                    if (job.$2.status != JobStatus.interview.toString())
                      MenuFlyoutItem(
                        text: const Text('Interview'),
                        onPressed: () {
                          // update the status
                          updateStatus(JobStatus.interview.toString(), job.$1);
                        },
                      ),
                    if (job.$2.status != JobStatus.offered.toString())
                      MenuFlyoutItem(
                        text: const Text('Offer'),
                        onPressed: () {
                          // update the status
                          updateStatus(JobStatus.offered.toString(), job.$1);
                        },
                      ),
                    if (job.$2.status != JobStatus.rejected.toString())
                      MenuFlyoutItem(
                        text: const Text('Rejected'),
                        onPressed: () {
                          // update the status
                          updateStatus(JobStatus.rejected.toString(), job.$1);
                        },
                      ),
                  ],
                )),
              ],
            );
          }).toList()),
    );
  }
}

// only the first character of the string is capitalized
extension StringExtension on String {
  String fcapitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
