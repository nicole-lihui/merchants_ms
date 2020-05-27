class GoodsItemEntity {
  int id;
  String icon;
  int shopId;
  String title;
  int type;
  int status;
  int count;
  double price;
  String stratTime;

  GoodsItemEntity(
      {this.id,
      this.icon,
      this.shopId,
      this.title,
      this.type,
      this.status,
      this.count,
      this.price,
      this.stratTime});

  GoodsItemEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    shopId = json['shopId'];
    title = json['title'];
    type = json['type'];
    status = json['status'];
    count = json['count'];
    price = json['price'];
    stratTime = json['stratTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['icon'] = icon;
    data['shopId'] = shopId;
    data['title'] = title;
    data['type'] = type;
    data['status'] = status;
    data['count'] = count;
    data['price'] = price;
    data['stratTime'] = stratTime;

    return data;
  }
}

class GoodsListEntity {
  List<GoodsItemEntity> items;

  GoodsListEntity({this.items});

  GoodsListEntity.fromJson(Map<String, dynamic> json) {
if (json['items'] != null) {
      items = new List<GoodsItemEntity>();
      (json['items'] as List).forEach((v) {
        items.add(new GoodsItemEntity.fromJson(v));
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
