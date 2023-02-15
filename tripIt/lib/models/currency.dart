class Currency {
  bool success;
  String terms;
  String privacy;
  int timestamp;
  String source;
  Quotes quotes;

  Currency(
      {this.success,
      this.terms,
      this.privacy,
      this.timestamp,
      this.source,
      this.quotes});

  Currency.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    terms = json['terms'];
    privacy = json['privacy'];
    timestamp = json['timestamp'];
    source = json['source'];
    quotes =
        json['quotes'] != null ? new Quotes.fromJson(json['quotes']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['terms'] = this.terms;
    data['privacy'] = this.privacy;
    data['timestamp'] = this.timestamp;
    data['source'] = this.source;
    if (this.quotes != null) {
      data['quotes'] = this.quotes.toJson();
    }
    return data;
  }
}

class Quotes {
  double uSDSAR;

  Quotes({this.uSDSAR});

  Quotes.fromJson(Map<String, dynamic> json) {
    uSDSAR = json['USDSAR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['USDSAR'] = this.uSDSAR;

    return data;
  }
}
