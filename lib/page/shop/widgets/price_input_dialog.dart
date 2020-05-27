import 'package:flutter/material.dart';
import 'package:merchant_ms/routers/fluro_navigator_utils.dart';
import 'package:merchant_ms/util/number_text_input_formatter.dart';
import 'package:merchant_ms/util/theme_utils.dart';
import 'package:merchant_ms/util/toast.dart';
import 'package:merchant_ms/widgets/base_dialog.dart';

class PriceInputDialog extends StatefulWidget{

  final String title;
  final Function(String) onPressed;

  PriceInputDialog({
    Key key,
    this.title,
    this.onPressed,
  }) : super(key : key);
  
  @override
  _PriceInputDialog createState() => _PriceInputDialog();
  
}

class _PriceInputDialog extends State<PriceInputDialog>{

  TextEditingController _controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: widget.title,
      child: Container(
        height: 34.0,
        margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        decoration: BoxDecoration(
          color: ThemeUtils.getDialogTextFieldColor(context),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: TextField(
          key: const Key('price_input'),
          autofocus: true,
          controller: _controller,
          maxLines: 1,
          //style: TextStyles.textDark14,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          // 金额限制数字格式
          inputFormatters: [UsNumberTextInputFormatter()],
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0, bottom: 14.0),
            border: InputBorder.none,
            hintText: '输入${widget.title}',
            //hintStyle: TextStyles.textGrayC14,
          ),
        ),
      ),
      onPressed: () {
        if (_controller.text.isEmpty) {
          Toast.show('请输入${widget.title}');         
          return;
        }
        NavigatorUtils.goBack(context);
        widget.onPressed(_controller.text);
      },
    );
  }
}
