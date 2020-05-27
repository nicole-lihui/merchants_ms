import 'package:flutter/material.dart';
import 'package:merchant_ms/common/common.dart';
import 'package:merchant_ms/mvp/base_page_state.dart';
import 'package:merchant_ms/page/order/models/order_entity.dart';
import 'package:merchant_ms/page/order/presenter/order_presenter.dart';
import 'package:merchant_ms/page/order/provider/order_page_provider.dart';
import 'package:merchant_ms/page/order/widgets/order_item.dart';
import 'package:merchant_ms/widgets/my_refresh_list.dart';
import 'package:merchant_ms/widgets/state_layout.dart';
import 'package:provider/provider.dart';

class OrderListPage extends StatefulWidget {
  final int index;

  const OrderListPage({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  OrderListPageState createState() => OrderListPageState();
}

class OrderListPageState extends BasePageState<OrderListPage, OrderPagePresenter>
    with AutomaticKeepAliveClientMixin<OrderListPage> {
  /// 是否正在加载数据
  bool _isLoading = false;
  int _page = 1;
  final int _maxPage = 3;
  StateType _stateType = StateType.loading;
  int _index = 0;
  ScrollController _controller = ScrollController();


  @override
  void initState() {
    super.initState();
    _index = widget.index;
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener(
      onNotification: (ScrollNotification note) {
        if (note.metrics.pixels == note.metrics.maxScrollExtent) {
          _loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        displacement: 120.0,

        /// 默认40， 多添加的80为Header高度
        child: Consumer<OrderPageProvider>(
          builder: (_, provider, child) {
            return CustomScrollView(
              /// 这里指定controller可以与外层NestedScrollView的滚动分离，避免一处滑动，5个Tab中的列表同步滑动。
              /// 这种方法的缺点是会重新layout列表
              controller: _index != provider.index ? _controller : null,
              key: PageStorageKey<String>('$_index'),
              slivers: <Widget>[
                SliverOverlapInjector(
                  ///SliverAppBar的expandedHeight高度,避免重叠
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                child
              ],
            );
          },
          child: SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: orderslist.isEmpty
                ? SliverFillRemaining(child: StateLayout(type: _stateType))
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return index < orderslist.length
                          ? 
                          // (index % 5 == 0 || index != 0
                          //     ? OrderTagItem(date: '2020年2月5日', orderTotal: 4)
                          //     : 
                              OrderItem(
                                  key: Key('order_item_$index'),
                                  index: index,
                                  tabIndex: _index,
                                  orderInfo: orderslist[index],
                                )
                            // )
                          : MoreWidget(orderslist.length, _hasMore(), 10);
                    }, childCount: orderslist.length + 1),
                  ),
          ),
        ),
      ),
    );
  }

  List<OrderItemEntity> orderslist = [];

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() async {
        _page = 1;
        // orderslist = List.generate(10, (i) => 'newItem：$i');
        await presenter.search(Constant.shopId, _index + 1, true, true);
      });
    });
  }

  bool _hasMore() {
    return _page < _maxPage;
  }

  Future _loadMore() async {
    if (_isLoading) {
      return;
    }
    if (!_hasMore()) {
      return;
    }
    _isLoading = true;
    await Future.delayed(Duration(seconds: 2), () {
      setState(() async {
        // orderslist.addAll(List.generate(10, (i) => 'newItem：$i'));
        await presenter.search(Constant.shopId, _index + 1, true, true);
        _page++;
        _isLoading = false;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  OrderPagePresenter createPresenter() {
    return new OrderPagePresenter();
  }
}
