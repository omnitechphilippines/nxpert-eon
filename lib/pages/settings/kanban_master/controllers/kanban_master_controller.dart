import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../utils/global_api_config.dart';
import '../models/kanban_model.dart';
import '../models/paginated_kanban_response.dart';

class KanbanMasterController {
  // Fetch paginated kanbans
  Future<PaginatedKanbanResponse> getKanbans({
    required int page,
    required int limit,
  }) async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}kanbanMasterGetKanbans?page=$page&limit=$limit',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return PaginatedKanbanResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load kanbans');
    }
  }

  // Search kanbans with optional filters
  Future<PaginatedKanbanResponse> searchKanbans({
    required int page,
    required int limit,
    String? kanbanPartNo,
    String? kanbanDefaultLocator,
    String? kanbanRemarks,
    String? kanbanDescription,
    String? kanbanCapacity,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'limit': limit.toString(),
      if (kanbanPartNo != null) 'kanbanPartNo': kanbanPartNo,
      if (kanbanDefaultLocator != null)
        'kanbanDefaultLocator': kanbanDefaultLocator,
      if (kanbanRemarks != null) 'kanbanRemarks': kanbanRemarks,
      if (kanbanDescription != null) 'kanbanDescription': kanbanDescription,
      if (kanbanDefaultLocator != null)
        'kanbanDefaultLocator': kanbanDefaultLocator,
      if (kanbanCapacity != null) 'kanbanCapacity': kanbanCapacity,
    };

    print(queryParams);

    final uri = Uri.parse(
      '${ApiConfig.baseUrl}kanbanMasterSearchKanban',
    ).replace(queryParameters: queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return PaginatedKanbanResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to search kanbans');
    }
  }

  // Add a new kanban
  Future<bool> insertKanban(Kanban kanban) async {
    final url = Uri.parse('${ApiConfig.baseUrl}kanbanMasterAddKanban');

    final body = {
      'Kbm_PartNo': kanban.kanbanPartNo,
      'Kbm_Description': kanban.kanbanDescription,
      'Kbm_Capacity': kanban.kanbanCapacity,
      'Kbm_Locator': kanban.kanbanDefaultLocator,
      'Kbm_Remarks': kanban.kanbanRemarks,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Insert Kanban Error: $e');
      return false;
    }
  }

  // Update an existing kanban
  Future<bool> updateKanban({
    required String kanbanId,
    String? kanbanPartNo,
    String? kanbanDescription,
    String? kanbanCapacity,
    String? kanbanDefaultLocator,
    String? kanbanRemarks,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}kanbanMasterUpdateKanban');

    final Map<String, dynamic> updateData = {
      'Kbm_ID': kanbanId,
      if (kanbanPartNo != null) 'Kbm_PartNo': kanbanPartNo,
      if (kanbanDescription != null) 'Kbm_Description': kanbanDescription,
      if (kanbanCapacity != null) 'Kbm_Capacity': kanbanCapacity,
      if (kanbanDefaultLocator != null) 'Kbm_Locator': kanbanDefaultLocator,
      if (kanbanRemarks != null) 'Kbm_Remarks': kanbanRemarks,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updateData),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Update Kanban Error: $e');
      return false;
    }
  }
}
