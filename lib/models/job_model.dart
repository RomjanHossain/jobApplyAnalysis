class JobModel {
  final String position;
  final String? jobPost;
  final String salary;
  final String? description;
  final String companyName;
  final String address;
  final String? website;
  final String? business;
  final DateTime appliedDate;

  const JobModel({
    required this.position,
    this.jobPost,
    required this.salary,
    this.description,
    required this.companyName,
    required this.address,
    this.website,
    this.business,
    required this.appliedDate,
  });

  // toMap method
  Map<String, dynamic> toMap() {
    return {
      'position': position,
      'jobPost': jobPost,
      'salary': salary,
      'description': description,
      'companyName': companyName,
      'address': address,
      'website': website,
      'business': business,
      'appliedDate': appliedDate.millisecondsSinceEpoch,
    };
  }

  // show the data beautifully (string)
  @override
  String toString() {
    return '{\n\tposition: $position, \n\tjobPost: $jobPost, \n\tsalary: $salary, \n\tdescription: $description, \n\tcompanyName: $companyName, \n\taddress: $address, \n\twebsite: $website, \n\tbusiness: $business, \nappliedDate: $appliedDate\n}';
  }
}
