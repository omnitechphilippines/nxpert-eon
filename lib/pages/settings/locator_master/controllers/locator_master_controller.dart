import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../utils/global_api_config.dart';
import '../models/paginated_locator_response.dart';
import '../models/locator_model.dart';

class LocatorMasterController {
  Future<PaginatedLocatorResponse> getLocators({
    required int page,
    required int limit,
  }) async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}locatorMasterGetLocators?page=$page&limit=$limit',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      return PaginatedLocatorResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load locators');
    }
  }

  Future<PaginatedLocatorResponse> searchLocator({
    required int page,
    required int limit,
    String? locatorCode,
    String? locatorDesc,
    String? locatorType,
    String? locatorArea,
    String? locatorOccupancyStatus,
    String? locatorStatus,
    String? userLogin,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'limit': limit.toString(),
      if (locatorCode != null) 'locatorCode': locatorCode,
      if (locatorDesc != null) 'locatorDesc': locatorDesc,
      if (locatorType != null) 'locatorType': locatorType,
      if (locatorArea != null) 'locatorArea': locatorArea,
      if (locatorOccupancyStatus != null) 'locatorOccupancyStatus': locatorOccupancyStatus,
      if (locatorStatus != null) 'locatorStatus': locatorStatus,
      if (userLogin != null) 'userLogin': userLogin,
    };

    final uri = Uri.parse(
      '${ApiConfig.baseUrl}locatorMasterSearchLocators',
    ).replace(queryParameters: queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      print(response.body);
      return PaginatedLocatorResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to search locators');
    }
  }

  Future<bool> insertLocator(Locator locator) async {
    final url = Uri.parse('${ApiConfig.baseUrl}locatorMasterAddLocator');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Lmt_Locatorcode': locator.locatorCode,
          'Lmt_Locatordesc': locator.locatorDesc,
          'Lmt_LocatorType': locator.locatorType,
          'Lmt_LocatorArea': locator.locatorArea,
          'Lmt_OccupancyStatus': locator.locatorOccupancyStatus,
          'Lmt_status': locator.locatorStatus,
          'User_login': locator.userLogin,
          'ludatetime': locator.ludatetime,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
          'Failed to insert locator. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Insert Locator Error: $e');
      return false;
    }
  }

  Future<bool> updateLocator({
    required String locatorCode,
    String? locatorDesc,
    String? locatorType,
    String? locatorArea,
    String? locatorOccupancyStatus,
    String? locatorStatus,
    String? userLogin,
    String? luDatetime,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}locatorMasterUpdateLocator');

    final Map<String, dynamic> updateData = {
      'Lmt_Locatorcode': locatorCode,
      if (locatorDesc != null) 'Lmt_Locatordesc': locatorDesc,
      if (locatorType != null) 'Lmt_LocatorType': locatorType,
      if (locatorArea != null) 'Lmt_LocatorArea': locatorArea,
      if (locatorOccupancyStatus != null) 'Lmt_OccupancyStatus': locatorOccupancyStatus,
      if (locatorStatus != null) 'Lmt_status': locatorStatus,
      if (userLogin != null) 'User_login': userLogin,
      if (luDatetime != null) 'ludatetime': luDatetime,
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
          'Failed to update locator. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Update Locator Error: $e');
      return false;
    }
  }
}