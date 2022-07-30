import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gsy_github_app_flutter/model/User.dart';
import 'package:gsy_github_app_flutter/page/home/widget/drawer_menu.dart';
import 'package:gsy_github_app_flutter/redux/gsy_state.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';

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
            child: new Container(
              color: store.state.themeData!.primaryColor,
              child: new SingleChildScrollView(
                child: Container(
                  constraints: new BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  child: new Material(
                    color: GSYColors.white,
                    child: new Column(
                      children: <Widget>[
                        new UserAccountsDrawerHeader(
                          accountName: new Text(
                            user.login ?? "---",
                            style: GSYConstant.largeTextWhite,
                          ),
                          accountEmail: new Text(
                            user.email ?? user.name ?? "---",
                            style: GSYConstant.normalTextLight,
                          ),
                          currentAccountPicture: new GestureDetector(
                            onTap: () {},
                            child: new CircleAvatar(
                              backgroundImage: new NetworkImage(
                                  user.avatar_url ??
                                      GSYICons.DEFAULT_REMOTE_PIC),
                            ),
                          ),
                          decoration: new BoxDecoration(
                            color: store.state.themeData!.primaryColor,
                          ),
                        ),
                        ...DrawerMenu(context: context).build(context, store)
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
