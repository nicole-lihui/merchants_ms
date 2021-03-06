import 'package:flutter/material.dart';
import 'package:merchant_ms/resources/colors.dart';
import 'package:merchant_ms/resources/dimens.dart';
import 'package:merchant_ms/util/theme_utils.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MyButton({
    Key key,
    this.text: '',
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    return FlatButton(
      onPressed: onPressed,
      textColor: isDark ? Colours.dark_button_text : Colors.white,
      color: isDark ? Colours.dark_app_main : Colours.app_main,
      disabledTextColor:
          isDark ? Colours.dark_text_disabled : Colours.text_disabled,
      disabledColor:
          isDark ? Colours.dark_button_disabled : Colours.button_disabled,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(fontSize: Dimens.font_sp18),
        ),
      ),
    );
  }
}
