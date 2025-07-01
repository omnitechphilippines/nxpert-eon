class Kanban {
  final String? kanbanId;
  final String? kanbanPartNo;
  final String? kanbanDescription;
  final String? kanbanCapacity;
  final String? kanbanDefaultLocator;
  final String? kanbanRemarks;

  Kanban({
    this.kanbanId,
    this.kanbanPartNo,
    this.kanbanDescription,
    this.kanbanCapacity,
    this.kanbanDefaultLocator,
    this.kanbanRemarks,
  });

  factory Kanban.fromJson(Map<String, dynamic> json) {
    return Kanban(
      kanbanId: json['Kbm_KanbanId']?.toString(),
      kanbanPartNo: json['Kbm_PartNo'],
      kanbanDescription: json['Kbm_Description'],
      kanbanCapacity: json['Kbm_Capacity']?.toString(),
      kanbanDefaultLocator: json['Kbm_DefaultLocator'],
      kanbanRemarks: json['Kbm_Remarks'],
    );
  }
}
