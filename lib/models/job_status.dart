import 'package:fluent_ui/fluent_ui.dart';

enum JobStatus {
  applied,
  messageOrCalled,
  interview,
  rejected,
  offered,
}

Color statusColor(JobStatus status) {
  switch (status) {
    case JobStatus.applied:
      return Colors.blue;
    case JobStatus.messageOrCalled:
      return Colors.green;
    case JobStatus.interview:
      return Colors.orange;
    case JobStatus.rejected:
      return Colors.red;
    case JobStatus.offered:
      return Colors.purple;
  }
}

// String to JobStatus
JobStatus stringToJobStatus(String status) {
  switch (status) {
    case 'applied':
      return JobStatus.applied;
    case 'messageOrCalled':
      return JobStatus.messageOrCalled;
    case 'interview':
      return JobStatus.interview;
    case 'rejected':
      return JobStatus.rejected;
    case 'offered':
      return JobStatus.offered;
    default:
      return JobStatus.applied;
  }
}

// JobStatus to String
String jobStatusToString(JobStatus status) {
  switch (status) {
    case JobStatus.applied:
      return 'Applied';
    case JobStatus.messageOrCalled:
      return 'MessageOrCalled';
    case JobStatus.interview:
      return 'Interview';
    case JobStatus.rejected:
      return 'Rejected';
    case JobStatus.offered:
      return 'Offered';
  }
}