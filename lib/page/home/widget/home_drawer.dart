import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gsy_github_app_flutter/common/config/config.dart';
import 'package:gsy_github_app_flutter/common/dao/issue_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/repos_dao.dart';
import 'package:gsy_github_app_flutter/common/local/local_storage.dart';
import 'package:gsy_github_app_flutter/common/localization/default_localizations.dart';
import 'package:gsy_github_app_flutter/model/User.dart';
import 'package:gsy_github_app_flutter/page/data_logic.dart';
import 'package:gsy_github_app_flutter/page/home/widget/drawer_menu_tile.dart';
import 'package:gsy_github_app_flutter/page/render_item.dart';
import 'package:gsy_github_app_flutter/redux/gsy_state.dart';
import 'package:gsy_github_app_flutter/redux/login_redux.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/common/utils/common_utils.dart';
import 'package:gsy_github_app_flutter/common/utils/navigator_utils.dart';
import 'package:gsy_github_app_flutter/widget/gsy_flex_button.dart';
import 'package:package_info/package_info.dart';
import 'package:redux/redux.dart';

/**
 * 主页drawer
 * Created by guoshuyu
 * Date: 2018-07-18
 */
class HomeDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: new StoreBuilder<GSYState>(
        builder: (context, store) {
          User user = store.state.userInfo!;
          return new Drawer(
            ///侧边栏按钮Drawer
            child: new Container(
              ///默认背景
              color: store.state.themeData!.primaryColor,
              child: new SingleChildScrollView(
                ///item 背景
                child: Container(
                  constraints: new BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  child: new Material(
                    color: GSYColors.white,
                    child: new Column(
                      children: <Widget>[
                        new UserAccountsDrawerHeader(
                          //Material内置控件
                          accountName: new Text(
                            user.login ?? "---",
                            style: GSYConstant.largeTextWhite,
                          ),
                          accountEmail: new Text(
                            user.email ?? user.name ?? "---",
                            style: GSYConstant.normalTextLight,
                          ),
                          //用户名
                          //用户邮箱
                          currentAccountPicture: new GestureDetector(
                            //用户头像
                            onTap: () {},
                            child: new CircleAvatar(
                              //圆形图标控件
                              backgroundImage: new NetworkImage(
                                  user.avatar_url ??
                                      GSYICons.DEFAULT_REMOTE_PIC),
                            ),
                          ),
                          decoration: new BoxDecoration(
                            //用一个BoxDecoration装饰器提供背景图片
                            color: store.state.themeData!.primaryColor,
                          ),
                        ),
                        DrawerMenuReply().setMenu(context, store),
                        DrawerMenuHistory().setMenu(context, store),
                        DrawerMenuUserInfo().setMenu(context, store),
                        DrawerMenuChangeTheme().setMenu(context, store),
                        DrawerMenuChangeLanguage().setMenu(context, store),
                        DrawerMenuChangeGrey().setMenu(context, store),
                        DrawerMenuCheckUpdate().setMenu(context, store),
                        DrawerMenuAbout().setMenu(context, store),
                        DrawerMenuLogout().setMenu(context, store)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
