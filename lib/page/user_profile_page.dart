import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gsy_github_app_flutter/common/localization/default_localizations.dart';
import 'package:gsy_github_app_flutter/page/user_profile_render_item.dart';
import 'package:gsy_github_app_flutter/redux/gsy_state.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';


const String user_profile_name = "名字";
const String user_profile_email = "邮箱";
const String user_profile_link = "链接";
const String user_profile_org = "公司";
const String user_profile_location = "位置";
const String user_profile_info = "简介";

/**
 * 用户信息中心
 * Created by guoshuyu
 * Date: 2018-08-08
 */
class UserProfileInfo extends StatefulWidget {
  UserProfileInfo();

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfileInfo> {

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<GSYState>(builder: (context, store) {
      return Scaffold(
        appBar: new AppBar(
            title: new Hero(
                tag: "home_user_info",
                child: new Material(
                    color: Colors.transparent,
                    child: new Text(
                      GSYLocalizations.i18n(context)!.home_user_info,
                      style: GSYConstant.normalTextWhite,
                    )))),
        body: new Container(
          color: GSYColors.white,
          child: new SingleChildScrollView(
            child: new Column(
              children: RenderList(context).build(store.state.userInfo!, store),
            ),
          ),
        ),
      );
    });
  }
}
