import 'product_model.dart';

class PaginatedProductResponse {
  final List<Product> products;
  final int totalCount;

  PaginatedProductResponse({required this.products, required this.totalCount});

  factory PaginatedProductResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedProductResponse(
      products:
          (json['data'] as List<dynamic>)
              .map((item) => Product.fromJson(item))
              .toList(),
      totalCount: json['total'] as int,
    );
  }
}
