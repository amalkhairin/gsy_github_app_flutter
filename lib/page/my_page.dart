import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gsy_github_app_flutter/common/dao/event_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/user_dao.dart';
import 'package:gsy_github_app_flutter/redux/gsy_state.dart';
import 'package:gsy_github_app_flutter/redux/user_redux.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/widget/pull/nested/gsy_nested_pull_load_widget.dart';
import 'package:gsy_github_app_flutter/page/user/base_person_state.dart';
import 'package:redux/redux.dart';

/**
 * 主页我的tab页
 * Created by guoshuyu
 * Date: 2018-07-16
 */
class MyPage extends StatefulWidget {
  MyPage({Key? key}) : super(key: key);
  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends BasePersonState<MyPage> {
  final ScrollController scrollController = ScrollController();

  String beStaredCount = '---';

  Color notifyColor = GSYColors.subTextColor;

  Store<GSYState>? _getStore() {
    return StoreProvider.of(context);
  }


  _getUserName() {
    if (_getStore()?.state.userInfo == null) {
      return null;
    }
    return _getStore()?.state.userInfo?.login;
  }


  getUserType() {
    if (_getStore()?.state.userInfo == null) {
      return null;
    }
    return _getStore()?.state.userInfo?.type;
  }

  _refreshNotify() {
    UserDao.getNotifyDao(false, false, 0).then((res) {
      Color newColor;
      if (res != null && res.result && res.data.length > 0) {
        newColor = GSYColors.actionBlue;
      } else {
        newColor = GSYColors.subLightTextColor;
      }
      if (isShow) {
        setState(() {
          notifyColor = newColor;
        });
      }
    });
  }

  scrollToTop() {
    if (scrollController.offset <= 0) {
      scrollController
          .animateTo(0,
              duration: Duration(milliseconds: 600), curve: Curves.linear)
          .then((_) {
        showRefreshLoading();
      });
    } else {
      scrollController.animateTo(0,
          duration: Duration(milliseconds: 600), curve: Curves.linear);
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    pullLoadWidgetControl.needHeader = true;
    super.initState();
  }

  _getDataLogic() async {
    if (_getUserName() == null) {
      return [];
    }
    if (getUserType() == "Organization") {
      return await UserDao.getMemberDao(_getUserName(), page);
    }
    return await EventDao.getEventDao(_getUserName(),
        page: page, needDb: page <= 1);
  }

  @override
  requestRefresh() async {
    if (_getUserName() != null) {

      _getStore()?.dispatch(FetchUserAction());

      getUserOrg(_getUserName());
      getHonor(_getUserName());
      _refreshNotify();
    }
    return await _getDataLogic();
  }

  @override
  requestLoadMore() async {
    return await _getDataLogic();
  }

  @override
  bool get isRefreshFirst => false;

  @override
  bool get needHeader => false;

  @override
  void didChangeDependencies() {
    if (pullLoadWidgetControl.dataList.length == 0) {
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new StoreBuilder<GSYState>(
      builder: (context, store) {
        return GSYNestedPullLoadWidget(
          pullLoadWidgetControl,
          (BuildContext context, int index) => renderItem(
              index, store.state.userInfo!, beStaredCount, notifyColor, () {
            _refreshNotify();
          }, orgList),
          handleRefresh,
          onLoadMore,
          scrollController: scrollController,
          refreshKey: refreshIKey,
          headerSliverBuilder: (context, _) {
            return sliverBuilder(
                context, _, store.state.userInfo!, notifyColor, beStaredCount,
                () {
              _refreshNotify();
            });
          },
        );
      },
    );
  }
}
