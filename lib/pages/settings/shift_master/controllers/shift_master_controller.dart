import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../utils/global_api_config.dart';
import '../models/shift_model.dart';
import '../models/paginated_shift_response.dart';

class ShiftMasterController {
  // Fetch paginated shift list
  Future<PaginatedShiftResponse> getShifts({
    required int page,
    required int limit,
  }) async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}shiftMasterGetShifts?page=$page&limit=$limit',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return PaginatedShiftResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load shifts');
    }
  }

  // Search shifts using optional parameters
  Future<PaginatedShiftResponse> searchShifts({
    required int page,
    required int limit,
    String? shiftCode,
    String? shiftDescription,
    String? scheduleType, // <-- This maps to "shift type"
    String? status, // <-- This maps to "shift status"
  }) async {
    final queryParams = {
      'page': page.toString(),
      'limit': limit.toString(),
      if (shiftCode != null) 'shiftCode': shiftCode,
      if (shiftDescription != null) 'shiftDescription': shiftDescription,
      if (scheduleType != null) 'scheduleType': scheduleType,
      if (status != null) 'status': status,
    };

    final uri = Uri.parse(
      '${ApiConfig.baseUrl}shiftMasterSearchShifts',
    ).replace(queryParameters: queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return PaginatedShiftResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search shifts');
    }
  }

  // Insert a new shift
  Future<bool> insertShift(ShiftModel shift) async {
    final url = Uri.parse('${ApiConfig.baseUrl}shiftMasterAddShift');

    print(shift);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(shift.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
          'Failed to insert shift. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Insert Shift Error: $e');
      return false;
    }
  }

  // Update an existing shift
  Future<bool> updateShift({
    required String shiftCode,
    String? shiftDescription,
    String? scheduleType,
    DateTime? timeIn,
    DateTime? breakStart,
    DateTime? breakEnd,
    DateTime? timeOut,
    double? totalHours,
    String? status,
    String? user,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}shiftMasterUpdateShift');

    final Map<String, dynamic> updateData = {
      'shiftCode': shiftCode,
      if (shiftDescription != null) 'shiftDescription': shiftDescription,
      if (scheduleType != null) 'scheduleType': scheduleType,
      if (timeIn != null) 'timeIn': timeIn.toIso8601String(),
      if (breakStart != null) 'breakStart': breakStart.toIso8601String(),
      if (breakEnd != null) 'breakEnd': breakEnd.toIso8601String(),
      if (timeOut != null) 'timeOut': timeOut.toIso8601String(),
      if (totalHours != null) 'totalHours': totalHours,
      if (status != null) 'status': status,
      if (user != null) 'user': user,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updateData),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
          'Failed to update shift. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Update Shift Error: $e');
      return false;
    }
  }
}
