class ShiftModel {
  final String shiftCode;
  final String shiftDescription;
  final String scheduleType;
  final DateTime timeIn;
  final DateTime? breakStart;
  final DateTime? breakEnd;
  final DateTime timeOut;
  final int totalHours;
  final String status;
  final String user;

  ShiftModel({
    required this.shiftCode,
    required this.shiftDescription,
    required this.scheduleType,
    required this.timeIn,
    this.breakStart,
    this.breakEnd,
    required this.timeOut,
    required this.totalHours,
    required this.status,
    required this.user,
  });

  /// Converts 'HHMM' string (e.g., '0530') to DateTime (today's date)
  static DateTime? parseTime(String? hhmm) {
    if (hhmm == null || hhmm.trim().isEmpty) return null;
    if (hhmm.length != 4) throw FormatException("Invalid time format: $hhmm");
    final hour = int.parse(hhmm.substring(0, 2));
    final minute = int.parse(hhmm.substring(2, 4));
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      shiftCode: json['Scm_ShiftCode'] ?? '',
      shiftDescription: json['Scm_ShiftDesc'] ?? '',
      scheduleType: json['Scm_ScheduleType'] ?? '',
      timeIn: parseTime(json['Scm_ShiftTimeIn'])!,
      breakStart: parseTime(json['Scm_ShiftBreakStart']),
      breakEnd: parseTime(json['Scm_ShiftBreakEnd']),
      timeOut: parseTime(json['Scm_ShiftTimeOut'])!,
      totalHours: int.tryParse(json['Scm_ShiftTotalHours'].toString()) ?? 0,
      status: json['Scm_Status'] ?? '',
      user: (json['User_Login'] ?? '').trim(),
    );
  }

  Map<String, dynamic> toJson() {
    String? formatTime(DateTime? dt) {
      if (dt == null) return null;
      return dt.hour.toString().padLeft(2, '0') +
          dt.minute.toString().padLeft(2, '0');
    }

    return {
      'Scm_ShiftCode': shiftCode,
      'Scm_ShiftDesc': shiftDescription,
      'Scm_ScheduleType': scheduleType,
      'Scm_ShiftTimeIn': formatTime(timeIn),
      'Scm_ShiftBreakStart': formatTime(breakStart),
      'Scm_ShiftBreakEnd': formatTime(breakEnd),
      'Scm_ShiftTimeOut': formatTime(timeOut),
      'Scm_ShiftTotalHours': totalHours,
      'Scm_Status': status,
      'User_Login': user,
    };
  }
}
