import 'package:gsy_github_app_flutter/common/dao/repos_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/user_dao.dart';
import 'package:gsy_github_app_flutter/common/utils/navigator_utils.dart';
import 'package:gsy_github_app_flutter/page/repos/widget/repos_item.dart';
import 'package:gsy_github_app_flutter/page/user/widget/user_item.dart';

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
}

class Item {
  static getItems(showType, data, context) {
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
