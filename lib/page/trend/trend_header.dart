import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gsy_github_app_flutter/common/localization/default_localizations.dart';
import 'package:gsy_github_app_flutter/common/style/gsy_style.dart';
import 'package:gsy_github_app_flutter/page/trend/trend_bloc.dart';
import 'package:gsy_github_app_flutter/page/trend/trend_page.dart';
import 'package:gsy_github_app_flutter/widget/gsy_card_item.dart';
import 'package:gsy_github_app_flutter/widget/pull/nested/nested_refresh.dart';

// ignore: must_be_immutable
class TrendHeader extends StatefulWidget {
  final store;
  final Radius? radius;
  TrendTypeModel? selectTime;
  TrendTypeModel? selectType;
  final timeList;
  final typeList;
  int? selectTimeIndex;
  int? selectTypeIndex;
  final TrendBloc? trendBloc;
  final ScrollController? scrollController;
  GlobalKey<NestedScrollViewRefreshIndicatorState>? refreshIndicatorKey;
  TrendHeader({Key? key, this.store, this.radius, this.selectTime, this.selectType, this.timeList, this.typeList, this.selectTimeIndex, this.selectTypeIndex, this.trendBloc, this.scrollController, this.refreshIndicatorKey}) : super(key: key);

  @override
  State<TrendHeader> createState() => _TrendHeaderState();
}

class _TrendHeaderState extends State<TrendHeader> with
        AutomaticKeepAliveClientMixin<TrendHeader>,
        SingleTickerProviderStateMixin {

  final GlobalKey<NestedScrollViewRefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<NestedScrollViewRefreshIndicatorState>();

  _showRefreshLoading() {
    new Future.delayed(const Duration(seconds: 0), () {
      refreshIndicatorKey.currentState!.show().then((e) {});
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GSYCardItem(
      color: widget.store!.state.themeData!.primaryColor,
      margin: EdgeInsets.all(0.0),
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.all(widget.radius!),
      ),
      child: new Padding(
        padding:
            new EdgeInsets.only(left: 0.0, top: 5.0, right: 0.0, bottom: 5.0),
        child: new Row(
          children: <Widget>[
            TrendHeaderPopItem(
              data: widget.selectTime!.name, 
              list: widget.timeList!,
              onSelected: (TrendTypeModel result) {
              if (widget.trendBloc!.isLoading) {
                Fluttertoast.showToast(
                    msg: GSYLocalizations.i18n(context)!.loading_text);
                return;
              }
              widget.scrollController!
                  .animateTo(0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.bounceInOut)
                  .then((_) {
                setState(() {
                  widget.selectTime = result;
                  widget.selectTimeIndex = widget.timeList!.indexOf(result);
                });
                _showRefreshLoading();
              });
            }),
            new Container(height: 10.0, width: 0.5, color: GSYColors.white),
            TrendHeaderPopItem(
                data: widget.selectType!.name,
                list: widget.typeList!,
                onSelected: (TrendTypeModel result) {
                  if (widget.trendBloc!.isLoading) {
                    Fluttertoast.showToast(
                        msg: GSYLocalizations.i18n(context)!.loading_text);
                    return;
                  }
                  widget.scrollController!
                      .animateTo(0,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.bounceInOut)
                      .then((_) {
                    setState(() {
                      widget.selectType = result;
                      widget.selectTypeIndex = widget.typeList!.indexOf(result);
                    });
                    _showRefreshLoading();
                  });
                }),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class TrendHeaderPopItem extends StatelessWidget {
  String? data;
  List<TrendTypeModel>? list;
  PopupMenuItemSelected<TrendTypeModel>? onSelected;
  TrendHeaderPopItem({Key? key, this.data, this.list, this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new PopupMenuButton<TrendTypeModel>(
        child: new Center(
            child: new Text(data!, style: GSYConstant.middleTextWhite)),
        onSelected: onSelected,
        itemBuilder: (BuildContext context) {
          return _renderHeaderPopItemChild(list!);
        },
      ),
    );
  }

  _renderHeaderPopItemChild(List<TrendTypeModel> data) {
    List<PopupMenuEntry<TrendTypeModel>> list = [];
    for (TrendTypeModel item in data) {
      list.add(PopupMenuItem<TrendTypeModel>(
        value: item,
        child: new Text(item.name),
      ));
    }
    return list;
  }
}
