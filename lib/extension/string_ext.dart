// only the first character of the string is capitalized
extension StringExtension on String {
  String fcapitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  // substring 10 characters
  String fsubstring() {
    return substring(0, length > 10 ? 10 : length);
  }

  // salary range (20k-30k)
  double? fsalary() {
    try {
      final List<String> salary = split('-'); // 20k-30k
      return double.parse(salary[0].substring(0, salary[0].length - 1));
    } catch (e) {
      return 0;
    }
  }
}

extension GetMonthNameFromDouble on double {
  String fgetMonthName() {
    switch (toInt()) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'Unknown';
    }
  }
}
