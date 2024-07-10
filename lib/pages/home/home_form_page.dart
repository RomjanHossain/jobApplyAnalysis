import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  DateTime? selected;

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
          ListView(
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
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              backgroundColor: FluentTheme.of(context).micaBackgroundColor,
              label: const Text('Save'),
              onPressed: () {
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
