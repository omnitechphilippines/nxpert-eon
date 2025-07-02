import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../utils/global_api_config.dart';
import '../models/product_model.dart';
import '../models/paginated_product_response.dart';

class ProductMasterController {
  // Fetch paginated products
  Future<PaginatedProductResponse> getProducts({
    required int page,
    required int limit,
  }) async {
    final url = Uri.parse(
      '${ApiConfig.baseUrl}productMasterGetProducts?page=$page&limit=$limit',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return PaginatedProductResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Search products with optional filters
  Future<PaginatedProductResponse> searchProducts({
    required int page,
    required int limit,
    String? productCode,
    String? productName,
    String? productSpecification,
    String? internalProdCode,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'limit': limit.toString(),
      if (productCode != null) 'productCode': productCode,
      if (productName != null) 'productName': productName,
      if (productSpecification != null)
        'productSpecification': productSpecification,
      if (internalProdCode != null) 'internalProdCode': internalProdCode,
    };

    final uri = Uri.parse(
      '${ApiConfig.baseUrl}productMasterSearchProducts',
    ).replace(queryParameters: queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return PaginatedProductResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to search products');
    }
  }

  // Add a new product
  Future<bool> insertProduct(Product product) async {
    final url = Uri.parse('${ApiConfig.baseUrl}productMasterAddProduct');

    final body = {
      'Pmt_Productcode': product.productCode,
      'Pmt_Productname': product.productName,
      'Pmt_ProductSpecification': product.productSpecification,
      'Pmt_InternalProdCode': product.productInternalCode,
      'Pmt_CostCenterCode': product.costCenterCode,
      'Pmt_ProdCategory': product.prodCategory,
      'Pmt_ProdSource': product.prodSource,
      'Pmt_RequireCPO': product.requireCPO,
      'Pmt_ProductUnit': product.productUnit,
      'Pmt_BMstatus': product.bmStatus,
      'Pmt_HasCurMthSched': product.hasCurMthSched,
      'Pmt_HasNxtMthSched': product.hasNxtMthSched,
      'Pmt_PSGroupCode': product.psGroupCode,
      'Pmt_MinLotSize': product.minLotSize,
      'Pmt_MaxLotSize': product.maxLotSize,
      'Pmt_ProdLeadTime': product.prodLeadTime,
      'Pmt_LeadTimeUnit': product.leadTimeUnit,
      'Pmt_ProdRegDate': product.prodRegDate?.toIso8601String(),
      'Pmt_Status': product.status,
      'Pmt_UserLogin': product.userLogin,
      'Pmt_LUDatetime': product.ludatetime.toIso8601String(),
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Insert Product Error: $e');
      return false;
    }
  }

  // Update an existing product
  Future<bool> updateProduct(Product product) async {
    final url = Uri.parse('${ApiConfig.baseUrl}productMasterUpdateProduct');

    final body = {
      'Pmt_Productcode': product.productCode,
      'Pmt_Productname': product.productName,
      'Pmt_ProductSpecification': product.productSpecification,
      'Pmt_InternalProdCode': product.productInternalCode,
      'Pmt_CostCenterCode': product.costCenterCode,
      'Pmt_ProdCategory': product.prodCategory,
      'Pmt_ProdSource': product.prodSource,
      'Pmt_RequireCPO': product.requireCPO,
      'Pmt_ProductUnit': product.productUnit,
      'Pmt_BMstatus': product.bmStatus,
      'Pmt_HasCurMthSched': product.hasCurMthSched,
      'Pmt_HasNxtMthSched': product.hasNxtMthSched,
      'Pmt_PSGroupCode': product.psGroupCode,
      'Pmt_MinLotSize': product.minLotSize,
      'Pmt_MaxLotSize': product.maxLotSize,
      'Pmt_ProdLeadTime': product.prodLeadTime,
      'Pmt_LeadTimeUnit': product.leadTimeUnit,
      'Pmt_ProdRegDate': product.prodRegDate?.toIso8601String(),
      'Pmt_Status': product.status,
      'Pmt_UserLogin': product.userLogin,
      'Pmt_LUDatetime': product.ludatetime.toIso8601String(),
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Update Product Error: $e');
      return false;
    }
  }
}
