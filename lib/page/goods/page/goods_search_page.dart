import 'package:flutter/material.dart';
import 'package:merchant_ms/util/toast.dart';
import 'package:merchant_ms/widgets/search_bar.dart';

class GoodsSearchPage extends StatefulWidget {
  @override
  _GoodsSearchPageState createState() => _GoodsSearchPageState();
}

class _GoodsSearchPageState extends State<GoodsSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(
        hintText: '请输入商品名称查询',
        onPressed: (text) {
          Toast.show('搜索内容：$text');
        },
      ),
      body: Container(),
    );
  }
}
