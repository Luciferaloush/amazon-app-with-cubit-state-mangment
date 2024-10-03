class Earnings {
  double? mobileEarnings;
  double? essentials;
  double? appliances;
  double? booksEarnings;
  double? fashionEarnings;

  Earnings(
      {this.mobileEarnings,
      this.essentials,
      this.appliances,
      this.booksEarnings,
      this.fashionEarnings});

  Earnings.fromJson(Map<String, dynamic> json) {
    mobileEarnings = (json['mobileEarnings'] is int)
        ? (json['mobileEarnings'] as int).toDouble()
        : json['mobileEarnings']?.toDouble();

    essentials = (json['essentials'] is int)
        ? (json['essentials'] as int).toDouble()
        : json['essentials']?.toDouble();

    appliances = (json['appliances'] is int)
        ? (json['appliances'] as int).toDouble()
        : json['appliances']?.toDouble();

    booksEarnings = (json['booksEarnings'] is int)
        ? (json['booksEarnings'] as int).toDouble()
        : json['booksEarnings']?.toDouble();

    fashionEarnings = (json['fashionEarnings'] is int)
        ? (json['fashionEarnings'] as int).toDouble()
        : json['fashionEarnings']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobileEarnings'] = mobileEarnings;
    data['essentials'] = essentials;
    data['appliances'] = appliances;
    data['booksEarnings'] = booksEarnings;
    data['fashionEarnings'] = fashionEarnings;
    return data;
  }
}
