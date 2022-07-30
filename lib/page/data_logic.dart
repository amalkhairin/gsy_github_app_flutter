
import 'package:gsy_github_app_flutter/common/dao/repos_dao.dart';
import 'package:gsy_github_app_flutter/common/dao/user_dao.dart';

abstract class DataLogic {
  getData(userName, reposName, page);
}

class DataFollower extends DataLogic {
  @override
  getData(userName, reposName, page) async {
    return await UserDao.getFollowerListDao(userName, page, needDb: page <= 1);
  }
}

class DataFollowed extends DataLogic {
  @override
  getData(userName, reposName, page) async {
    return await UserDao.getFollowedListDao(userName, page, needDb: page <= 1);
  }
}

class DataUserRepos extends DataLogic {
  @override
  getData(userName, reposName, page) async {
    return await ReposDao.getUserRepositoryDao(userName, page, null,
        needDb: page <= 1);
  }
}

class DataUserStar extends DataLogic {
  @override
  getData(userName, reposName, page) async {
    return await ReposDao.getStarRepositoryDao(userName, page, null,
        needDb: page <= 1);
  }
}

class DataRepoStar extends DataLogic {
  @override
  getData(userName, reposName, page) async {
    return await ReposDao.getRepositoryStarDao(userName, reposName, page,
        needDb: page <= 1);
  }
}

class DataRepoWatcher extends DataLogic {
  @override
  getData(userName, reposName, page) async {
    return await ReposDao.getRepositoryWatcherDao(userName, reposName, page,
        needDb: page <= 1);
  }
}

class DataRepoFork extends DataLogic {
  @override
  getData(userName, reposName, page) async {
    return await ReposDao.getRepositoryForksDao(userName, reposName, page,
        needDb: page <= 1);
  }
}

class DataHistory extends DataLogic {
  @override
  getData(userName, reposName, page) async {
    return await ReposDao.getHistoryDao(page);
  }
}

class DataTopics extends DataLogic {
  @override
  getData(userName, reposName, page) async {
    return await ReposDao.searchTopicRepositoryDao(userName, page: page);
  }
}

class DataUserOrg extends DataLogic {
  @override
  getData(userName, reposName, page) async {
    return await UserDao.getUserOrgsDao(userName, page, needDb: page <= 1);
  }
}
