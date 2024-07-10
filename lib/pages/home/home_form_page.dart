import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:joblookup/models/job_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  DateTime? selected;
  bool isLoading = false;

  late TextEditingController _positionController;
  late TextEditingController _jobPostController;
  late TextEditingController _salaryController;
  late TextEditingController _descriptionController;
  // company info
  late TextEditingController _companyNameController;
  late TextEditingController _addressController;
  late TextEditingController _websiteController;
  late TextEditingController _businessController;
  @override
  void initState() {
    super.initState();

    _positionController = TextEditingController();
    _jobPostController = TextEditingController();
    _salaryController = TextEditingController();
    _descriptionController = TextEditingController();
    _companyNameController = TextEditingController();
    _addressController = TextEditingController();
    _websiteController = TextEditingController();
    _businessController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _positionController.dispose();
    _jobPostController.dispose();
    _salaryController.dispose();
    _descriptionController.dispose();
    _companyNameController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    _businessController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              children: [
                Text(
                  "Job Information",
                  style: FluentTheme.of(context).typography.title,
                ),
                // position
                InfoLabel(
                  label: 'Position',
                  child: TextBox(
                    controller: _positionController,
                  ),
                ),
                // job post
                InfoLabel(
                  label: 'Job Post Link',
                  child: TextBox(
                    controller: _jobPostController,
                  ),
                ),
                // salary
                InfoLabel(
                  label: 'Salary Range',
                  child: TextBox(
                    controller: _salaryController,
                  ),
                ),
                // description
                InfoLabel(
                  label: 'Description',
                  child: TextBox(
                    controller: _descriptionController,
                    maxLines: 10,
                  ),
                ),
                Text(
                  "Company Information",
                  style: FluentTheme.of(context).typography.title,
                ),
                const SizedBox(height: 20),
                InfoLabel(
                  label: 'Company Name',
                  child: TextBox(
                    controller: _companyNameController,
                  ),
                ),
                // address
                InfoLabel(
                    label: 'Address',
                    child: TextBox(
                      controller: _addressController,
                    )),
                // website
                InfoLabel(
                    label: 'Website',
                    child: TextBox(
                      controller: _websiteController,
                    )),
                // business
                InfoLabel(
                    label: 'Business',
                    child: TextBox(
                      maxLines: 5,
                      controller: _businessController,
                    )),
                Text(
                  "Applied Information",
                  style: FluentTheme.of(context).typography.title,
                ),
                const SizedBox(height: 20),
                InfoLabel(
                  label: 'Applied Date',
                  child: DatePicker(
                    selected: selected,
                    onChanged: (time) => setState(() => selected = time),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: material.FloatingActionButton.extended(
              backgroundColor: FluentTheme.of(context).micaBackgroundColor,
              label: const Text('Save'),
              onPressed: () {
                if (_companyNameController.text.isNotEmpty &&
                    _addressController.text.isNotEmpty &&
                    _salaryController.text.isNotEmpty &&
                    _positionController.text.isNotEmpty &&
                    selected != null) {
                  // printing all the text
                  print("Position: ${_positionController.text}");
                  print("Job Post: ${_jobPostController.text}");
                  print("Salary: ${_salaryController.text}");
                  print("Description: ${_descriptionController.text}");
                  print("Company Name: ${_companyNameController.text}");
                  print("Address: ${_addressController.text}");
                  print("Website: ${_websiteController.text}");
                  print("Business: ${_businessController.text}");
                  print("Applied Date: $selected");
                  final JobModel job = JobModel(
                    position: _positionController.text,
                    jobPost: _jobPostController.text,
                    salary: _salaryController.text,
                    description: _descriptionController.text,
                    companyName: _companyNameController.text,
                    address: _addressController.text,
                    website: _websiteController.text,
                    business: _businessController.text,
                    appliedDate: selected!,
                  );
                  showContentDialog(context, job);
                } else {
                  // show error message
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void resetTextInputs() {
    _positionController.clear();
    _jobPostController.clear();
    _salaryController.clear();
    _descriptionController.clear();
    _companyNameController.clear();
    _addressController.clear();
    _websiteController.clear();
    _businessController.clear();
  }

  void showContentDialog(BuildContext context, JobModel job) async {
    // print("The default Database: ${await getDatabasesPath()}");
    await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Are You Sure?'),
        content: isLoading
            ? const Center(
                child: ProgressRing(),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Check the information before saving.',
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                      child:
                          SingleChildScrollView(child: Text(job.toString()))),
                ],
              ),
        actions: [
          Button(
            onPressed: isLoading
                ? null
                : () async {
                    setState(() {
                      isLoading = true;
                    });
                    var databaseFactory = databaseFactoryFfi;
                    final Directory appDocumentsDir =
                        await getApplicationDocumentsDirectory();
                    String dbPath =
                        p.join(appDocumentsDir.path, "jobDatabase", "job.db");
                    if (!await Directory(p.dirname(dbPath)).exists()) {
                      await Directory(p.dirname(dbPath))
                          .create(recursive: true);
                    }
                    final db = await databaseFactory.openDatabase(dbPath);
                    await db.execute(
                        "CREATE TABLE IF NOT EXISTS jobs (id INTEGER PRIMARY KEY AUTOINCREMENT, position TEXT, jobPost TEXT, salary TEXT, description TEXT, companyName TEXT, address TEXT, website TEXT, business TEXT, appliedDate TEXT)");
                    await db.insert("jobs", job.toMap());
                    await db.close();
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pop(
                      context,
                    );
                    // Delete file here
                  },
            child: const Text('Okay'),
          ),
          FilledButton(
            onPressed: isLoading
                ? null
                : () => Navigator.pop(
                      context,
                    ),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
