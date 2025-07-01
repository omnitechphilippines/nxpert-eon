import 'shift_model.dart';

class PaginatedShiftResponse {
  final List<ShiftModel> shifts;
  final int total;

  PaginatedShiftResponse({required this.shifts, required this.total});

  factory PaginatedShiftResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedShiftResponse(
      shifts:
          (json['data'] as List)
              .map((item) => ShiftModel.fromJson(item))
              .toList(),
      total: json['total'],
    );
  }
}
