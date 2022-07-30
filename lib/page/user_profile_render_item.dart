import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:gsy_github_app_flutter/common/dao/user_dao.dart';
import 'package:gsy_github_app_flutter/common/localization/default_localizations.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/model/User.dart';
import 'package:gsy_github_app_flutter/widget/gsy_card_item.dart';

class RenderItem extends StatelessWidget {
  final IconData? leftIcon;
  final String? title;
  final String? value;
  final VoidCallback? onPressed;
  RenderItem(
      {Key? key, this.leftIcon, this.title, this.value, this.onPressed})
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

abstract class UserProfileItem {
  BuildContext? context;
  UserProfileItem(this.context);

  setItem(User userInfo, Store store);
}

class ProfileNameItem extends UserProfileItem {
  BuildContext? context;
  ProfileNameItem(this.context) : super(context);
  @override
  setItem(User userInfo, Store store) {
    return RenderItem(
      leftIcon: Icons.info,
      title: GSYLocalizations.i18n(context!)!.user_profile_name,
      value: userInfo.name ?? "---",
      onPressed: () {
        EditDialog.showEditDialog(
            context!,
            GSYLocalizations.i18n(context!)!.user_profile_name,
            userInfo.name,
            "name",
            store);
      },
    );
  }
}

class ProfileEmailItem extends UserProfileItem {
  BuildContext? context;
  ProfileEmailItem(this.context) : super(context);
  @override
  setItem(User userInfo, Store store) {
    return RenderItem(
      leftIcon: Icons.email,
      title: GSYLocalizations.i18n(context!)!.user_profile_email,
      value: userInfo.email ?? "---",
      onPressed: () {
        EditDialog.showEditDialog(
            context!,
            GSYLocalizations.i18n(context!)!.user_profile_email,
            userInfo.email,
            "email",
            store);
      },
    );
  }
}

class ProfileLinkItem extends UserProfileItem {
  BuildContext? context;
  ProfileLinkItem(this.context) : super(context);
  @override
  setItem(User userInfo, Store store) {
    return RenderItem(
      leftIcon: Icons.link,
      title: GSYLocalizations.i18n(context!)!.user_profile_link,
      value: userInfo.blog ?? "---",
      onPressed: () {
        EditDialog.showEditDialog(
            context!,
            GSYLocalizations.i18n(context!)!.user_profile_link,
            userInfo.blog,
            "blog",
            store);
      },
    );
  }
}

class ProfileOrgItem extends UserProfileItem {
  BuildContext? context;
  ProfileOrgItem(this.context) : super(context);
  @override
  setItem(User userInfo, Store store) {
    return RenderItem(
      leftIcon: Icons.group,
      title: GSYLocalizations.i18n(context!)!.user_profile_org,
      value: userInfo.company ?? "---",
      onPressed: () {
        EditDialog.showEditDialog(
            context!,
            GSYLocalizations.i18n(context!)!.user_profile_org,
            userInfo.company,
            "company",
            store);
      },
    );
  }
}

class ProfileLocationItem extends UserProfileItem {
  BuildContext? context;
  ProfileLocationItem(this.context) : super(context);
  @override
  setItem(User userInfo, Store store) {
    return RenderItem(
      leftIcon: Icons.location_on,
      title: GSYLocalizations.i18n(context!)!.user_profile_location,
      value: userInfo.location ?? "---",
      onPressed: () {
        EditDialog.showEditDialog(
            context!,
            GSYLocalizations.i18n(context!)!.user_profile_location,
            userInfo.location,
            "location",
            store);
      },
    );
  }
}

class ProfileInfoItem extends UserProfileItem {
  BuildContext? context;
  ProfileInfoItem(this.context) : super(context);
  @override
  setItem(User userInfo, Store store) {
    return RenderItem(
      leftIcon: Icons.message,
      title: GSYLocalizations.i18n(context!)!.user_profile_info,
      value: userInfo.bio ?? "---",
      onPressed: () {
        EditDialog.showEditDialog(
            context!,
            GSYLocalizations.i18n(context!)!.user_profile_info,
            userInfo.bio,
            "bio",
            store);
      },
    );
  }
}

class EditDialog {
  static showEditDialog(BuildContext context, String title, String? value,
      String key, store) {
    String content = value ?? "";
    CommonUtils.showEditDialog(context, title, (title) {}, (res) {
      content = res;
    }, () {
      if (content.length == 0) {
        return;
      }
      CommonUtils.showLoadingDialog(context);

      UserDao.updateUserDao({key: content}, store).then((res) {
        Navigator.of(context).pop();
        if (res != null && res.result) {
          Navigator.of(context).pop();
        }
      });
    },
        titleController: new TextEditingController(),
        valueController: new TextEditingController(text: value),
        needTitle: false);
  }
}
