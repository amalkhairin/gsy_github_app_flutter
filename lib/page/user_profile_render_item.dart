import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/widget/gsy_card_item.dart';

class RenderItem extends StatelessWidget {
  final IconData? leftIcon;
  final String? title;
  final String? value;
  final VoidCallback? onPressed;
  RenderItem({Key? key, this.leftIcon, this.title, this.value, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GSYCardItem(
      child: new RawMaterialButton(
        onPressed: onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.all(15.0),
        constraints: const BoxConstraints(minWidth: 0.0, minHeight: 0.0),
        child: new Row(
          children: <Widget>[
            new Icon(leftIcon),
            new Container(
              width: 10.0,
            ),
            new Text(title!, style: GSYConstant.normalSubText),
            new Container(
              width: 10.0,
            ),
            new Expanded(
                child: new Text(value!, style: GSYConstant.normalText)),
            new Container(
              width: 10.0,
            ),
            new Icon(GSYICons.REPOS_ITEM_NEXT, size: 12.0),
          ],
        ),
      ),
    );
  }
}
