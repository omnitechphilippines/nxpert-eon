class Pallet {
  final String? palletCode;
  final String? palletDescription;
  final String? palletColor;
  final String? palletCategory;
  final String? palletStatus;

  Pallet({
    this.palletCode,
    this.palletDescription,
    this.palletColor,
    this.palletCategory,
    this.palletStatus,
  });

  factory Pallet.fromJson(Map<String, dynamic> json) {
    return Pallet(
      palletCode: json['Ptm_PalletCode'] as String?,
      palletDescription: json['Ptm_PalletDesc'] as String?,
      palletColor: json['Ptm_PalletColor'] as String?,
      palletCategory: json['Ptm_Category'] as String?,
      palletStatus: json['Ptm_Status'] as String?,
    );
  }
}
