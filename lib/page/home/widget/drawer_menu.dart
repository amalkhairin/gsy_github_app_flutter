import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:gsy_github_app_flutter/common/config/config.dart';
import 'package:gsy_github_app_flutter/common/dao/issue_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/repos_dao.dart';
import 'package:gsy_github_app_flutter/common/local/local_storage.dart';
import 'package:gsy_github_app_flutter/common/localization/default_localizations.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/navigator_utils.dart';
import 'package:gsy_github_app_flutter/redux/login_redux.dart';
import 'package:gsy_github_app_flutter/widget/gsy_flex_button.dart';
import 'package:package_info/package_info.dart';

class DrawerMenu {
  final BuildContext? context;
  const DrawerMenu({ Key? key, this.context});

  showThemeDialog(BuildContext context, store) {
    StringList list = [
      GSYLocalizations.i18n(context)!.home_theme_default,
      GSYLocalizations.i18n(context)!.home_theme_1,
      GSYLocalizations.i18n(context)!.home_theme_2,
      GSYLocalizations.i18n(context)!.home_theme_3,
      GSYLocalizations.i18n(context)!.home_theme_4,
      GSYLocalizations.i18n(context)!.home_theme_5,
      GSYLocalizations.i18n(context)!.home_theme_6,
    ];
    CommonUtils.showCommitOptionDialog(context, list, (index) {
      CommonUtils.pushTheme(store, index);
      LocalStorage.save(Config.THEME_COLOR, index.toString());
    }, colorList: CommonUtils.getThemeListColor());
  }

  showAboutDialog(BuildContext context, String? versionName) {
    versionName ??= "Null";
    NavigatorUtils.showGSYDialog(
        context: context,
        builder: (BuildContext context) => AboutDialog(
              applicationName: GSYLocalizations.i18n(context)!.app_name,
              applicationVersion: GSYLocalizations.i18n(context)!.app_version +
                  ": " +
                  (versionName ?? ""),
              applicationIcon: new Image(
                  image: new AssetImage(GSYICons.DEFAULT_USER_ICON),
                  width: 50.0,
                  height: 50.0),
              applicationLegalese: "http://github.com/CarGuo",
            ));
  }

  build(BuildContext context, store) {
    return [
      new ListTile(
        title: new Text(
          GSYLocalizations.i18n(context)!.home_reply,
          style: GSYConstant.normalText,
        ),
        onTap: () {
          String content = "";
          CommonUtils.showEditDialog(
              context,
              GSYLocalizations.i18n(context)!.home_reply,
              (title) {}, (res) {
            content = res;
          }, () {
            if (content.length == 0) {
              return;
            }
            CommonUtils.showLoadingDialog(context);
            IssueDao.createIssueDao(
                "CarGuo", "gsy_github_app_flutter", {
              "title":
                  GSYLocalizations.i18n(context)!.home_reply,
              "body": content
            }).then((result) {
              Navigator.pop(context);
              Navigator.pop(context);
            });
          },
              titleController: new TextEditingController(),
              valueController: new TextEditingController(),
              needTitle: false);
        }),
    new ListTile(
        title: new Text(
          GSYLocalizations.i18n(context)!.home_history,
          style: GSYConstant.normalText,
        ),
        onTap: () {
          NavigatorUtils.gotoCommonList(
              context,
              GSYLocalizations.i18n(context)!.home_history,
              "repositoryql",
              "history",
              userName: "",
              reposName: "");
        }),
    new ListTile(
        title: new Hero(
            tag: "home_user_info",
            child: new Material(
                color: Colors.transparent,
                child: new Text(
                  GSYLocalizations.i18n(context)!
                      .home_user_info,
                  style: GSYConstant.normalTextBold,
                ))),
        onTap: () {
          NavigatorUtils.gotoUserProfileInfo(context);
        }),
    new ListTile(
        title: new Text(
          GSYLocalizations.i18n(context)!.home_change_theme,
          style: GSYConstant.normalText,
        ),
        onTap: () {
          showThemeDialog(context, store);
        }),
    new ListTile(
        title: new Text(
          GSYLocalizations.i18n(context)!
              .home_change_language,
          style: GSYConstant.normalText,
        ),
        onTap: () {
          CommonUtils.showLanguageDialog(context);
        }),

    new ListTile(
        title: new Text(
          GSYLocalizations.i18n(context)!
              .home_change_grey,
          style: GSYConstant.normalText,
        ),
        onTap: () {
          CommonUtils.changeGrey(store);
        }),
    new ListTile(
        title: new Text(
          GSYLocalizations.i18n(context)!.home_check_update,
          style: GSYConstant.normalText,
        ),
        onTap: () {
          ReposDao.getNewsVersion(context, true);
        }),
    new ListTile(
        title: new Text(
          GSYLocalizations.of(context)!
              .currentLocalized!
              .home_about,
          style: GSYConstant.normalText,
        ),
        onLongPress: (){
          NavigatorUtils.goDebugDataPage(context);
        },
        onTap: () {
          PackageInfo.fromPlatform().then((value) {
            print(value);
            showAboutDialog(context, value.version);
          });
        }),
    new ListTile(
        title: new GSYFlexButton(
          text: GSYLocalizations.i18n(context)!.Login_out,
          color: Colors.redAccent,
          textColor: GSYColors.textWhite,
          onPress: () {
            store.dispatch(LogoutAction(context));
          },
        ),
        onTap: () {}),
    ];
  }
}