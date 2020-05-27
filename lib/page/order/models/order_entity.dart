class OrderItemEntity {
  int id;
  String phone;
  String userName;
  String payType;
  String address;
  String price;
  int count;
  String startTime;
  String endTime;
  List<dynamic> goodsName;
  List<dynamic> goodsCount;
  int status;

  OrderItemEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    userName = json['userName'];
    payType = json['payType'];
    address = json['address'];
    price = json['price'];
    count = json['count'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    goodsName = json['goodsName'];
    goodsCount = json['goodsCount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['phone'] = phone;
    data['userName'] = userName;
    data['payType'] = payType;
    data['address'] = address;
    data['price'] = price;
    data['count'] = count;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['goodsName'] = goodsName;
    data['goodsCount'] = goodsCount;
    data['status'] = status;
  }
}

class OrderListEntity {
  List<OrderItemEntity> items;

  OrderListEntity({this.items});

  OrderListEntity.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<OrderItemEntity>();
      (json['items'] as List).forEach((v) {
        items.add(new OrderItemEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
