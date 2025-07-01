import 'kanban_model.dart';

class PaginatedKanbanResponse {
  final List<Kanban> kanbans;
  final int totalCount;

  PaginatedKanbanResponse({required this.kanbans, required this.totalCount});

  factory PaginatedKanbanResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedKanbanResponse(
      kanbans:
          (json['data'] as List<dynamic>)
              .map((e) => Kanban.fromJson(e))
              .toList(),
      totalCount: json['total'] ?? 0,
    );
  }
}
