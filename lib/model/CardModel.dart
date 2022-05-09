class CardModel {
  String? card;
  String? number;

  CardModel({this.card, this.number});

  CardModel.fromJson(Map<String, dynamic> json) {
    card = json['card'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card'] = this.card;
    data['number'] = this.number;
    return data;
  }
}
