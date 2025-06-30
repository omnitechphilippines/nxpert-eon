import 'locator_model.dart';

class PaginatedLocatorResponse {
  final List<Locator> locators;
  final int total;

  PaginatedLocatorResponse({required this.locators, required this.total});

  factory PaginatedLocatorResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedLocatorResponse(
      locators:
          (json['data'] as List)
              .map((locator) => Locator.fromJson(locator))
              .toList(),
      total: json['total'] ?? 0,
    );
  }
}
