class Locator {
  final String? locatorCode;
  final String? locatorDesc;
  final String? locatorType;
  final String? locatorArea;
  final String? locatorOccupancyStatus;
  final String? locatorStatus;
  final String? locatorWarehouseCode;
  final String? userLogin;
  final String? ludatetime;

  Locator({
    this.locatorCode,
    this.locatorDesc,
    this.locatorType,
    this.locatorArea,
    this.locatorOccupancyStatus,
    this.locatorStatus,
    this.locatorWarehouseCode,
    this.userLogin,
    this.ludatetime,
  });

  factory Locator.fromJson(Map<String, dynamic> json) {
    return Locator(
      locatorCode: json['Lmt_LocatorCode']?.toString().trim(),
      locatorDesc: json['Lmt_LocatorDesc']?.toString().trim(),
      locatorType: json['Lmt_LocatorType']?.toString().trim(),
      locatorArea: json['Lmt_LocatorArea']?.toString().trim(),
      locatorOccupancyStatus: json['Lmt_OccupancyStatus']?.toString().trim(),
      locatorStatus: json['Lmt_Status']?.toString().trim(),
      locatorWarehouseCode: json['Lmt_WarehouseCode']?.toString().trim(), // ✅ fixed
      userLogin: json['User_login']?.toString().trim(),
      ludatetime: json['Lu_datetime']?.toString().trim(),
    );
  }
}
