import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/dao/user_dao.dart';
import 'package:gsy_github_app_flutter/common/localization/default_localizations.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/widget/gsy_card_item.dart';

class RenderItem extends StatelessWidget {
  final IconData? leftIcon;
  final String? title;
  final String? value;
  final VoidCallback? onPressed;
  RenderItem({ Key? key, this.leftIcon, this.title, this.value, this.onPressed }) : super(key: key);


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
            new Expanded(child: new Text(value!, style: GSYConstant.normalText)),
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

class RenderList {
  BuildContext? context;
  RenderList(context);

  _showEditDialog(String title, String? value, String key, store) {
    String content = value ?? "";
    CommonUtils.showEditDialog(this.context!, title, (title) {}, (res) {
      content = res;
    }, () {
      if (content.length == 0) {
        return;
      }
      CommonUtils.showLoadingDialog(this.context!);

      UserDao.updateUserDao({key: content}, store).then((res) {
        Navigator.of(this.context!).pop();
        if (res != null && res.result) {
          Navigator.of(this.context!).pop();
        }
      });
    },
        titleController: new TextEditingController(),
        valueController: new TextEditingController(text: value),
        needTitle: false);
  }

  List<Widget> build(userInfo, store){
    return [
      RenderItem(
        leftIcon: Icons.info,
        title: GSYLocalizations.i18n(this.context!)!.user_profile_name,
        value: userInfo.name ?? "---",
        onPressed: () {
          _showEditDialog(GSYLocalizations.i18n(this.context!)!.user_profile_name,
              userInfo.name, "name", store);
        },
      ),
      RenderItem(
        leftIcon: Icons.email,
        title: GSYLocalizations.i18n(this.context!)!.user_profile_email,
        value: userInfo.email ?? "---",
        onPressed: () {
          _showEditDialog(GSYLocalizations.i18n(this.context!)!.user_profile_email,
              userInfo.email, "email", store);
        },
      ),
      RenderItem(
        leftIcon: Icons.link,
        title: GSYLocalizations.i18n(this.context!)!.user_profile_link,
        value: userInfo.blog ?? "---",
        onPressed: () {
          _showEditDialog(GSYLocalizations.i18n(this.context!)!.user_profile_link,
              userInfo.blog, "blog", store);
        },
      ),
      RenderItem(
        leftIcon: Icons.group,
        title: GSYLocalizations.i18n(this.context!)!.user_profile_org,
        value: userInfo.company ?? "---",
        onPressed: () {
          _showEditDialog(GSYLocalizations.i18n(this.context!)!.user_profile_org,
              userInfo.company, "company", store);
        },
      ),
      RenderItem(
        leftIcon: Icons.location_on,
        title: GSYLocalizations.i18n(this.context!)!.user_profile_location,
        value: userInfo.location ?? "---",
        onPressed: () {
          _showEditDialog(GSYLocalizations.i18n(this.context!)!.user_profile_location,
              userInfo.location, "location", store);
        },
      ),
      RenderItem(
        leftIcon: Icons.message,
        title: GSYLocalizations.i18n(this.context!)!.user_profile_info,
        value: userInfo.bio ?? "---",
        onPressed: () {
          _showEditDialog(GSYLocalizations.i18n(this.context!)!.user_profile_info,
              userInfo.bio, "bio", store);
        },
      )
    ];
  }
}