import 'package:freezed_annotation/freezed_annotation.dart';
part 'job_model.freezed.dart';
part 'job_model.g.dart';

@freezed
class JobModel with _$JobModel {
  const factory JobModel({
    required String position,
    String? jobPost,
    required String salary,
    String? description,
    required String companyName,
    required String address,
    String? website,
    String? business,
    required DateTime appliedDate,
    String? status,
  }) = _JobModel;

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);
}
