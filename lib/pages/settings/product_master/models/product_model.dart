class Product {
  final String productCode;
  final String productName;
  final String productSpecification;
  final String productInternalCode;
  final String costCenterCode;
  final DateTime? prodRegDate;
  final String prodCategory;
  final String prodSource;
  final bool requireCPO;
  final String productUnit;
  final String bmStatus;
  final bool hasCurMthSched;
  final bool hasNxtMthSched;
  final String psGroupCode;
  final int? minLotSize;
  final int? maxLotSize;
  final double? prodLeadTime;
  final String leadTimeUnit;
  final String status;
  final String userLogin;
  final DateTime ludatetime;

  Product({
    required this.productCode,
    required this.productName,
    required this.productSpecification,
    required this.productInternalCode,
    required this.costCenterCode,
    required this.prodRegDate,
    required this.prodCategory,
    required this.prodSource,
    required this.requireCPO,
    required this.productUnit,
    required this.bmStatus,
    required this.hasCurMthSched,
    required this.hasNxtMthSched,
    required this.psGroupCode,
    required this.minLotSize,
    required this.maxLotSize,
    required this.prodLeadTime,
    required this.leadTimeUnit,
    required this.status,
    required this.userLogin,
    required this.ludatetime,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productCode: json['Pmt_Productcode'] ?? '',
      productName: json['Pmt_Productname'] ?? '',
      productSpecification: json['Pmt_ProductSpecification'] ?? '',
      productInternalCode: json['Pmt_InternalProdCode'] ?? '',
      costCenterCode: json['Pmt_CostCenterCode'] ?? '',
      prodRegDate:
          json['Pmt_ProdRegDate'] != null
              ? DateTime.tryParse(json['Pmt_ProdRegDate'])
              : null,
      prodCategory: json['Pmt_ProdCategory'] ?? '',
      prodSource: json['Pmt_ProdSource'] ?? '',
      requireCPO: json['Pmt_RequireCPO'] == true || json['Pmt_RequireCPO'] == 1,
      productUnit: json['Pmt_ProductUnit'] ?? '',
      bmStatus: json['Pmt_BMstatus'] ?? '',
      hasCurMthSched:
          json['Pmt_HasCurMthSched'] == true || json['Pmt_HasCurMthSched'] == 1,
      hasNxtMthSched:
          json['Pmt_HasNxtMthSched'] == true || json['Pmt_HasNxtMthSched'] == 1,
      psGroupCode: json['Pmt_PSGroupCode'] ?? '',
      minLotSize: json['Pmt_MinLotSize'],
      maxLotSize: json['Pmt_MaxLotSize'],
      prodLeadTime: json['Pmt_ProdLeadTime']?.toDouble(),
      leadTimeUnit: json['Pmt_LeadTimeUnit'] ?? '',
      status: json['Pmt_Status'] ?? '',
      userLogin: json['Pmt_UserLogin'] ?? '',
      ludatetime:
          DateTime.tryParse(json['Pmt_LUDateTime'] ?? '') ??
          DateTime.now(), // fallback
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Pmt_Productcode': productCode,
      'Pmt_Productname': productName,
      'Pmt_ProductSpecification': productSpecification,
      'Pmt_InternalProdCode': productInternalCode,
      'Pmt_CostCenterCode': costCenterCode,
      'Pmt_ProdRegDate': prodRegDate?.toIso8601String(), // nullable ISO format
      'Pmt_ProdCategory': prodCategory,
      'Pmt_ProdSource': prodSource,
      'Pmt_RequireCPO': requireCPO,
      'Pmt_ProductUnit': productUnit,
      'Pmt_BMstatus': bmStatus,
      'Pmt_HasCurMthSched': hasCurMthSched,
      'Pmt_HasNxtMthSched': hasNxtMthSched,
      'Pmt_PSGroupCode': psGroupCode,
      'Pmt_MinLotSize': minLotSize,
      'Pmt_MaxLotSize': maxLotSize,
      'Pmt_ProdLeadTime': prodLeadTime,
      'Pmt_LeadTimeUnit': leadTimeUnit,
      'Pmt_Status': status,
      'Pmt_UserLogin': userLogin,
      'Pmt_LUDateTime': ludatetime.toIso8601String(),
    };
  }
}
