import 'package:flutter/material.dart';
import 'package:gsy_github_app_flutter/common/utils/navigator_utils.dart';
import 'package:gsy_github_app_flutter/page/repos/widget/repos_item.dart';
import 'package:gsy_github_app_flutter/page/user/widget/user_item.dart';

abstract class ShowType {
	setItem(BuildContext context, data);
}

class RepositoryItem extends ShowType {

  @override
  setItem(context, data){
  	ReposViewModel reposViewModel = ReposViewModel.fromMap(data);
  	return new ReposItem(reposViewModel, onPressed: () {
      NavigatorUtils.goReposDetail(
          context, reposViewModel.ownerName, reposViewModel.repositoryName);
    });
  }
}

class RepositoryqlItem extends ShowType {

  @override
  setItem(context, data){
  	ReposViewModel reposViewModel = ReposViewModel.fromQL(data);
    return new ReposItem(reposViewModel, onPressed: () {
      NavigatorUtils.goReposDetail(
          context, reposViewModel.ownerName, reposViewModel.repositoryName);
    });
  }
}

class UserDataItem extends ShowType {@override
  setItem(context, data){
  	return new UserItem(UserItemViewModel.fromMap(data), onPressed: () {
      NavigatorUtils.goPerson(context, data.login);
    });
  }
}

class OrgItem extends ShowType {
  setItem(context, data){
  	return new UserItem(UserItemViewModel.fromOrgMap(data), onPressed: () {
      NavigatorUtils.goPerson(context, data.login);
    });
  }
}

class IssueItem extends ShowType {
  setItem(context, data){
  	return null;
  }
}

class ReleaseItem extends ShowType {
  setItem(context, data){
  	return null;
  }
}

class NotifyItem extends ShowType {
  setItem(context, data){
  	return null;
  }
}