import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
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
                child: TextBox(),
              ),
              // job post
              InfoLabel(
                label: 'Job Post Link',
                child: TextBox(),
              ),
              // salary
              InfoLabel(
                label: 'Salary Range',
                child: TextBox(),
              ),
              // description
              InfoLabel(
                label: 'Description',
                child: TextBox(
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
                child: TextBox(),
              ),
              // address
              InfoLabel(label: 'Address', child: TextBox()),
              // website
              InfoLabel(label: 'Website', child: TextBox()),
              // business
              InfoLabel(
                  label: 'Business',
                  child: TextBox(
                    maxLines: 5,
                  )),
              Text(
                "Applied Information",
                style: FluentTheme.of(context).typography.title,
              ),
              const SizedBox(height: 20),
              InfoLabel(
                label: 'Applied Date',
                child: DatePicker(
                  selected: null,
                ),
              ),
              // status
              InfoLabel(
                label: 'Status',
                child: ComboBox<String>(
                  items: [
                    ComboBoxItem(
                      value: 'Applied',
                      child: Text('Applied'),
                    ),
                    ComboBoxItem(
                      value: 'Interview',
                      child: Text('Interview'),
                    ),
                    ComboBoxItem(
                      value: 'Offer',
                      child: Text('Offer'),
                    ),
                    ComboBoxItem(
                      value: 'Rejected',
                      child: Text('Rejected'),
                    ),
                  ],
                  onChanged: (value) {},
                  placeholder: Text("Select Status"),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              label: const Text('Save'),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
