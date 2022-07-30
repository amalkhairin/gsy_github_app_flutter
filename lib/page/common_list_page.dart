import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/dao/repos_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/user_dao.dart';
import 'package:gsy_github_app_flutter/common/utils/navigator_utils.dart';
import 'package:gsy_github_app_flutter/page/data_logic.dart';
import 'package:gsy_github_app_flutter/page/render_item.dart';
import 'package:gsy_github_app_flutter/widget/state/gsy_list_state.dart';
import 'package:gsy_github_app_flutter/widget/pull/gsy_pull_load_widget.dart';
import 'package:gsy_github_app_flutter/page/repos/widget/repos_item.dart';
import 'package:gsy_github_app_flutter/page/user/widget/user_item.dart';

/**
 * 通用list
 * Created by guoshuyu
 * on 2018/7/22.
 */

class CommonListPage extends StatefulWidget {
  final String? userName;

  final String? reposName;

  final ShowType? showType;

  final DataLogic? dataType;

  final String? title;

  CommonListPage(this.title, this.showType, this.dataType,
      {this.userName, this.reposName});

  @override
  _CommonListPageState createState() => _CommonListPageState();
}

class _CommonListPageState extends State<CommonListPage>
    with
        AutomaticKeepAliveClientMixin<CommonListPage>,
        GSYListState<CommonListPage> {
  _CommonListPageState();

  _renderItem(index) {
    if (pullLoadWidgetControl.dataList.length == 0) {
      return null;
    }
    var data = pullLoadWidgetControl.dataList[index];
    return widget.showType!.setItem(context, data);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  requestRefresh() async {
    return await widget.dataType!.getData(widget.userName, widget.reposName, page);
  }

  @override
  requestLoadMore() async {
    return await widget.dataType!.getData(widget.userName, widget.reposName, page);
  }

  @override
  bool get isRefreshFirst => true;

  @override
  bool get needHeader => false;

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
        widget.title ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )),
      body: GSYPullLoadWidget(
        pullLoadWidgetControl,
        (BuildContext context, int index) => _renderItem(index),
        handleRefresh,
        onLoadMore,
        refreshKey: refreshIndicatorKey,
      ),
    );
  }
}
