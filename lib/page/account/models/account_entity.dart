class AccountEntity {
  int id;
  String phone;
  int shopId;
  String userName;
  double moneny;
  
  AccountEntity({this.id, this.phone, this.shopId, this.userName, this.moneny});

  AccountEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    shopId = json['shopId'];
    userName = json['userName'];
    moneny = json['moneny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['phone'] = phone;
    data['shopId'] = shopId;
    data['userName'] = userName;
    data['moneny'] = moneny;

    return data;
  }
}
