import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../utils/global_api_config.dart';
import '../models/pallet_model.dart';
import '../models/paginated_pallet_response.dart';

class PalletMasterController {
  // Fetch paginated pallets
  Future<PaginatedPalletResponse> getPallets({
    required int page,
    required int limit,
  }) async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}palletMasterGetPallets?page=$page&limit=$limit',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return PaginatedPalletResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load pallets');
    }
  }

  // Search pallets with optional filters
  Future<PaginatedPalletResponse> searchPallets({
    required int page,
    required int limit,
    String? palletCode,
    String? palletCategory,
    String? palletColor,
    String? palletStatus,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'limit': limit.toString(),
      if (palletCode != null) 'palletCode': palletCode,
      if (palletCategory != null) 'palletCategory': palletCategory,
      if (palletColor != null) 'palletColor': palletColor,
      if (palletStatus != null) 'palletStatus': palletStatus,
    };

    final uri = Uri.parse(
      '${ApiConfig.baseUrl}palletMasterSearchPallets',
    ).replace(queryParameters: queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return PaginatedPalletResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to search pallets');
    }
  }

  // Add a new pallet
  Future<bool> insertPallet(Pallet pallet) async {
    final url = Uri.parse('${ApiConfig.baseUrl}palletMasterAddPallet');

    final body = {
      'Ptm_PalletCode': pallet.palletCode,
      'Ptm_PalletDesc': pallet.palletDescription,
      'Ptm_PalletColor': pallet.palletColor,
      'Ptm_Category': pallet.palletCategory,
      'Ptm_Status': pallet.palletStatus,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Insert Pallet Error: $e');
      return false;
    }
  }

  // Update an existing pallet
  Future<bool> updatePallet({
    required String palletCode,
    String? palletDescription,
    String? palletColor,
    String? palletCategory,
    String? palletStatus,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}palletMasterUpdatePallet');

    final Map<String, dynamic> updateData = {
      'Ptm_PalletCode': palletCode,
      if (palletDescription != null) 'Ptm_PalletDesc': palletDescription,
      if (palletColor != null) 'Ptm_PalletColor': palletColor,
      if (palletCategory != null) 'Ptm_Category': palletCategory,
      if (palletStatus != null) 'Ptm_Status': palletStatus,
    };

    try {
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updateData),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Update Pallet Error: $e');
      return false;
    }
  }
}
