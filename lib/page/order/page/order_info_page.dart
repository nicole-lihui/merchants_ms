import 'package:flutter/material.dart';
import 'package:merchant_ms/mvp/base_page_state.dart';
import 'package:merchant_ms/page/order/models/order_entity.dart';
import 'package:merchant_ms/page/order/order_router.dart';
import 'package:merchant_ms/page/order/presenter/order_presenter.dart';
import 'package:merchant_ms/resources/resources.dart';
import 'package:merchant_ms/routers/fluro_navigator_utils.dart';
import 'package:merchant_ms/util/theme_utils.dart';
import 'package:merchant_ms/util/utils.dart';
import 'package:merchant_ms/widgets/app_bar.dart';
import 'package:merchant_ms/widgets/load_images.dart';

class OrderInfoPage extends StatefulWidget {

  const OrderInfoPage({Key key, this.id}) : super(key: key);
  
  final String id;

  @override
  OrderInfoPageState createState() => OrderInfoPageState();
}

class OrderInfoPageState extends BasePageState<OrderInfoPage, OrderInfoPagePresenter>
    with AutomaticKeepAliveClientMixin<OrderInfoPage> {

  OrderItemEntity orderInfo = null;
  String _id = '0';

  @override
  void initState() {
    _id = widget.id;
    _onRefresh();
    super.initState();
  }

    Future _onRefresh() async {

    await Future.delayed(Duration(seconds: 0), () {
      setState(() async {
        // orderslist = List.generate(10, (i) => 'newItem：$i');
        // await presenter.getOrder(_id, true, true);
        await presenter.getOrder(_id, true, true);
        
      });
    });

  }

  

  
  @override
  Widget build(BuildContext context) {

    Color red = Theme.of(context).errorColor;
    Color blue = Theme.of(context).primaryColor;
    bool isDark = ThemeUtils.isDark(context);
    return Scaffold(
      appBar: MyAppBar(
        actionName: '订单跟踪',
        onPressed: () {
          NavigatorUtils.push(context, OrderRouter.orderTrackPage);
        },
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            key: const Key('order_info'),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        '暂未接单',
                        style: TextStyles.textBold24,
                      ),
                      Gaps.vGap16,
                      Gaps.vGap16,
                      const Text(
                        '客户信息',
                        style: TextStyles.textBold18,
                      ),
                      Gaps.vGap16,
                      Row(
                        children: <Widget>[
                          // 忽略图片的语义
                          ClipOval(
                            child: const LoadAssetImage('order/icon_avatar', width: 44.0, height: 44.0),
                          ),
                          Gaps.hGap8,
                          Expanded(
                            // 合并Text的语义
                            child: MergeSemantics(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${orderInfo.userName}'),
                                  Gaps.vGap8,
                                  Text('${orderInfo.phone}'),
                                ],
                              ),
                            ),
                          ),
                          Gaps.vLine,
                          Gaps.hGap16,
                          Semantics(
                            label: '拨打电话',
                            child: GestureDetector(
                              child: const LoadAssetImage('order/icon_phone', width: 24.0, height: 24.0),
                              onTap: () => _showCallPhoneDialog('${orderInfo.phone}'),
                            ),
                          )
                        ],
                      ),
                      Gaps.vGap10,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const LoadAssetImage('order/icon_address', width: 16.0, height: 20.0),
                          Gaps.hGap4,
                          Expanded(child: Text('${orderInfo.address}', maxLines: 2)),
                        ],
                      ),
                      Gaps.vGap16,
                      Gaps.vGap16,
                      const Text(
                        '商品信息',
                        style: TextStyles.textBold18,
                      ),
                      ListView.builder(
                        // 如果滚动视图在滚动方向无界约束，那么shrinkWrap必须为true
                        shrinkWrap: true,
                        // 禁用ListView滑动，使用外层的ScrollView滑动
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 2,
                        itemBuilder: (_, index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: Divider.createBorderSide(context, width: 0.8),
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: const LoadAssetImage('order/icon_goods', width: 56.0, height: 56.0),
                                    margin: const EdgeInsets.only(top: 5.0),
                                  ),
                                  Gaps.hGap8,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            // index % 2 == 0 ? '泊泉雅花瓣·浪漫亲肤玫瑰沐浴乳' : '日本纳鲁火多橙饮',
                                            '${orderInfo.goodsName[index]}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                        Gaps.vGap4,
                                        Text(
                                          // index % 2 == 0 ? '玫瑰香 520ml' : '125ml', 
                                          '${orderInfo.goodsCount[index]}',
                                          style: Theme.of(context).textTheme.subtitle),
                                        // ExampleWidget,
                                        Gaps.vGap8,
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              decoration: BoxDecoration(
                                                color: red,
                                                borderRadius: BorderRadius.circular(2.0),
                                              ),
                                              height: 16.0,
                                              alignment: Alignment.center,
                                              child: Text(
                                                '立减2.50元',
                                                style: const TextStyle(color: Colors.white, fontSize: Dimens.font_sp10,),
                                              ),
                                            ),
                                            Gaps.hGap4,
                                            Offstage(
                                              offstage: index % 2 != 0,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                decoration: BoxDecoration(
                                                  color: blue,
                                                  borderRadius: BorderRadius.circular(2.0),
                                                ),
                                                height: 16.0,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '抵扣2.50元',
                                                  style: const TextStyle(color: Colors.white, fontSize: Dimens.font_sp10),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Gaps.hGap8,
                                  Text('${orderInfo.goodsCount[index]}', style: TextStyles.textSize12),
                                  Gaps.hGap16,
                                  Gaps.hGap16,
                                  Text(Utils.formatPrice('${orderInfo.price}'), style: TextStyles.textBold14),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Gaps.vGap8,
                      _getGoodsInfoItem('共2件商品', Utils.formatPrice('${orderInfo.price}')),
                      _getGoodsInfoItem('配送费', Utils.formatPrice('5.00')),
                      _getGoodsInfoItem('立减', Utils.formatPrice('-2.50'), contentTextColor: red),
                      _getGoodsInfoItem('优惠券', Utils.formatPrice('-2.50'), contentTextColor: red),
                      _getGoodsInfoItem('社区币抵扣', Utils.formatPrice('-2.50'), contentTextColor: red),
                      _getGoodsInfoItem('佣金', Utils.formatPrice('-1.0'), contentTextColor: red),
                      Gaps.line,
                      Gaps.vGap8,
                      _getGoodsInfoItem('合计', Utils.formatPrice('${orderInfo.price}')),
                      Gaps.vGap8,
                      Gaps.line,
                      Gaps.vGap16,
                      Gaps.vGap16,
                      const Text(
                        '订单信息',
                        style: TextStyles.textBold18,
                      ),
                      Gaps.vGap12,
                      _getOrderInfoItem('订单编号:', '${orderInfo.id}-1256324856942'),
                      _getOrderInfoItem('下单时间:', '2020/02/02 12:20'),
                      _getOrderInfoItem('支付方式:', '在线支付/支付宝'),
                      _getOrderInfoItem('配送方式:', '送货上门'),
                      _getOrderInfoItem('客户备注:', '无'),
                      Gaps.vGap50,
                      Gaps.vGap50,
                    ],
                  ),
                ],
              )
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Material(
              color: ThemeUtils.getBackgroundColor(context),
              child: SafeArea(
                child: Container(
                  height: 60.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      buttonTheme: ButtonThemeData(
                        height: 44.0,
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            color: isDark ? Colours.dark_material_bg : const Color(0xFFE1EAFA),
                            textColor: isDark ? Colours.dark_text : Colours.app_main,
                            child: const Text(
                              '拒单',
                              style: TextStyle(
                                  fontSize: Dimens.font_sp18
                              ),
                            ),
                            onPressed: () {
                        //
                            },
                          ),
                        ),
                        Gaps.hGap16,
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            color: blue,
                            textColor: isDark ? Colours.dark_button_text : Colors.white,
                            child: const Text(
                              '接单',
                              style: TextStyle(
                                  fontSize: Dimens.font_sp18
                              ),
                            ),
                            onPressed: () {
                              //
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getOrderInfoItem(String title, String content) {
    return MergeSemantics(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: Dimens.font_sp14)),
            Gaps.hGap8,
            Text(content)
          ],
        ),
      ),
    );
  }
  
  Widget _getGoodsInfoItem(String title, String content, {Color contentTextColor}) {
    return MergeSemantics(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title),
            Text(content, style: TextStyle(
              color: contentTextColor ?? Theme.of(context).textTheme.body1.color,
              fontWeight: FontWeight.bold
            ))
          ],
        ),
      ),
    );
  }

  void _showCallPhoneDialog(String phone) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('提示'),
            content: Text('是否拨打：$phone ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => NavigatorUtils.goBack(context),
                child: const Text('取消'),
              ),
              FlatButton(
                onPressed: () {
                  Utils.launchTelURL(phone);
                  NavigatorUtils.goBack(context);
                },
                textColor: Theme.of(context).errorColor,
                child: const Text('拨打'),
              ),
            ],
          );
        });
  }

  @override
  OrderInfoPagePresenter createPresenter() {
   return new OrderInfoPagePresenter();
  }

  @override
  bool get wantKeepAlive => true;
}
