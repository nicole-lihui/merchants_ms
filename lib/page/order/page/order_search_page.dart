import 'package:flutter/material.dart';
import 'package:merchant_ms/mvp/base_page_state.dart';
import 'package:merchant_ms/page/order/models/search_entity.dart';
import 'package:merchant_ms/page/order/presenter/order_search_presenter.dart';
import 'package:merchant_ms/provider/base_list_provider.dart';
import 'package:merchant_ms/widgets/my_refresh_list.dart';
import 'package:merchant_ms/widgets/search_bar.dart';
import 'package:merchant_ms/widgets/state_layout.dart';
import 'package:provider/provider.dart';

class OrderSearchPage extends StatefulWidget {
  @override
  OrderSearchPageState createState() => OrderSearchPageState();
}

class OrderSearchPageState extends BasePageState<OrderSearchPage, OrderSearchPresenter> {

  BaseListProvider<SearchItem> provider = BaseListProvider<SearchItem>();
  
  String _keyword;
  int _page = 1;
  
  @override
  void initState() {
    /// 默认为加载中状态，本页面场景默认为空
    provider.setStateTypeNotNotify(StateType.empty);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<SearchItem>>(
      create: (_) => provider,
      child: Scaffold(
        appBar: SearchBar(
          hintText: '请输入手机号或姓名查询',
          onPressed: (text) {
            if (text.isEmpty) {
              showToast('搜索关键字不能为空！');
              return;
            }
            FocusScope.of(context).unfocus();
            _keyword = text;
            provider.setStateType(StateType.loading);
            _page = 1;
            presenter.search(_keyword, _page, true);
          },
        ),
        body: Consumer<BaseListProvider<SearchItem>>(
          builder: (_, provider, __) {
            return DeerListView(
              key: Key('order_search_list'),
              itemCount: provider.list.length,
              stateType: provider.stateType,
              onRefresh: _onRefresh,
              loadMore: _loadMore,
              itemExtent: 50.0,
              hasMore: provider.hasMore,
              itemBuilder: (_, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(provider.list[index].name),
                );
              },
            );
          }
        ),
      ),
    );
  }

  Future _onRefresh() async {
    _page = 1;
    await presenter.search(_keyword, _page, false);
  }

  Future _loadMore() async {
    _page++;
    await presenter.search(_keyword, _page, false);
  }

  @override
  OrderSearchPresenter createPresenter() {
    return OrderSearchPresenter();
  }
}
