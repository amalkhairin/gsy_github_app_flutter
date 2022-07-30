import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/dao/repos_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/user_dao.dart';
import 'package:gsy_github_app_flutter/common/utils/navigator_utils.dart';
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

  final String showType;

  final String dataType;

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
    return Data.getDataItem(widget.showType, data, context);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  requestRefresh() async {
    return await Data.getDataLogic(widget.dataType, widget.userName, page, widget.reposName);
  }

  @override
  requestLoadMore() async {
    return await Data.getDataLogic(widget.dataType, widget.userName, page, widget.reposName);
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

class Data {
  static getDataLogic(dataType, userName, page, reposName) async {
    switch (dataType) {
      case 'follower':
        return await UserDao.getFollowerListDao(userName, page,
            needDb: page <= 1);
      case 'followed':
        return await UserDao.getFollowedListDao(userName, page,
            needDb: page <= 1);
      case 'user_repos':
        return await ReposDao.getUserRepositoryDao(userName, page, null,
            needDb: page <= 1);
      case 'user_star':
        return await ReposDao.getStarRepositoryDao(userName, page, null,
            needDb: page <= 1);
      case 'repo_star':
        return await ReposDao.getRepositoryStarDao(userName, reposName, page,
            needDb: page <= 1);
      case 'repo_watcher':
        return await ReposDao.getRepositoryWatcherDao(userName, reposName, page,
            needDb: page <= 1);
      case 'repo_fork':
        return await ReposDao.getRepositoryForksDao(userName, reposName, page,
            needDb: page <= 1);
      case 'repo_release':
        return null;
      case 'repo_tag':
        return null;
      case 'notify':
        return null;
      case 'history':
        return await ReposDao.getHistoryDao(page);
      case 'topics':
        return await ReposDao.searchTopicRepositoryDao(userName, page: page);
      case 'user_be_stared':
        return null;
      case 'user_orgs':
        return await UserDao.getUserOrgsDao(userName, page, needDb: page <= 1);
    }
  }

  static getDataItem(showType, data, context) {
    switch (showType) {
      case 'repository':
        ReposViewModel reposViewModel = ReposViewModel.fromMap(data);
        return new ReposItem(reposViewModel, onPressed: () {
          NavigatorUtils.goReposDetail(
              context, reposViewModel.ownerName, reposViewModel.repositoryName);
        });
      case 'repositoryql':
        ReposViewModel reposViewModel = ReposViewModel.fromQL(data);
        return new ReposItem(reposViewModel, onPressed: () {
          NavigatorUtils.goReposDetail(
              context, reposViewModel.ownerName, reposViewModel.repositoryName);
        });
      case 'user':
        return new UserItem(UserItemViewModel.fromMap(data), onPressed: () {
          NavigatorUtils.goPerson(context, data.login);
        });
      case 'org':
        return new UserItem(UserItemViewModel.fromOrgMap(data), onPressed: () {
          NavigatorUtils.goPerson(context, data.login);
        });
      case 'issue':
        return null;
      case 'release':
        return null;
      case 'notify':
        return null;
    }
  }
}
