import 'pallet_model.dart';

class PaginatedPalletResponse {
  final List<Pallet> pallets;
  final int totalCount;

  PaginatedPalletResponse({required this.pallets, required this.totalCount});

  factory PaginatedPalletResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedPalletResponse(
      pallets:
          (json['data'] as List<dynamic>)
              .map((e) => Pallet.fromJson(e))
              .toList(),
      totalCount: json['total'] ?? 0,
    );
  }
}
