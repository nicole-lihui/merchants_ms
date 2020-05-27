import 'package:merchant_ms/page/account/models/account_entity.dart';
import 'package:merchant_ms/page/goods/models/goods_item_entity.dart';
import 'package:merchant_ms/page/login/model/login_entity.dart';
import 'package:merchant_ms/page/order/models/order_entity.dart';
import 'package:merchant_ms/page/order/models/search_entity.dart';
import 'package:merchant_ms/page/shop/models/user_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    var t = T.toString();
    if (1 == 0) {
      return null;
    } else if (T.toString() == 'SearchEntity') {
      return SearchEntity.fromJson(json) as T;
    } else if (T.toString() == 'UserEntity') {
      return UserEntity.fromJson(json) as T;
    } else if (T.toString() == 'LoginEntity') {
      return LoginEntity.fromJson(json) as T;
    } else if (T.toString() == 'GoodsItemEntity') {
      return GoodsItemEntity.fromJson(json) as T;
    } else if (T.toString() == 'OrderItemEntity') {
      return OrderItemEntity.fromJson(json) as T;
    } else if (T.toString() == 'AccountEntity') {
      return AccountEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
