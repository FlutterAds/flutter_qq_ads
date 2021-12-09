import 'package:flutter/material.dart';
import 'package:flutter_qq_ads/flutter_qq_ads.dart';
import 'package:loadany/loadany.dart';

import 'ads_config.dart';

/// 信息流页面
class FeedPage extends StatefulWidget {
  FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<int> feedList = [];
  List<int> feedAdList = [];

  LoadStatus loadStatus = LoadStatus.normal;

  @override
  void initState() {
    getFeedList();
    super.initState();
  }

  @override
  void dispose() {
    clearFeedAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('信息流（FlutterAds）'),
      ),
      body: LoadAny(
        onLoadMore: () async {
          getFeedList();
        },
        status: loadStatus,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index % 10 == 4) {
                    int adIndex = index ~/ 10;
                    print('adIndex:$adIndex');
                    if (adIndex >= feedAdList.length) {
                      return Container(
                        height: 80,
                        width: double.maxFinite,
                        color: Colors.blueAccent,
                        alignment: Alignment.centerLeft,
                        child: Text('暂无广告 $index'),
                      );
                    }

                    int adId = feedAdList[adIndex];
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: AdFeedWidget(
                        posId: '$adId',
                        width: 375,
                        height: 128,
                        show: true,
                      ),
                    );
                  }
                  return LoadingItemWidget();
                },
                childCount: feedList.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 加载信息流
  Future<void> getFeedList() async {
    setState(() {
      loadStatus = LoadStatus.loading;
    });
    await Future.delayed(Duration(seconds: 2));
    for (var i = 0; i < 30; i++) {
      feedList.add(i);
    }
    getFeedAdList();
  }

  // 加载信息流广告
  Future<void> getFeedAdList() async {
    try {
      // int feedIdIndex = feedAdList.length ~/ 3 % AdsConfig.feedIdList.length;
      // print('feedIdIndex:$feedIdIndex');
      List<int> adResultList = await FlutterQqAds.loadFeedAd(
        AdsConfig.feedId,
        count: 3,
      );
      feedAdList.addAll(adResultList);
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      loadStatus = LoadStatus.normal;
    });
  }

  // 清除信息流广告
  Future<void> clearFeedAd() async {
    bool result = await FlutterQqAds.clearFeedAd(feedAdList);
    print('clearFeedAd:$result');
  }
}

/// 加载项组件
class LoadingItemWidget extends StatelessWidget {
  const LoadingItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.maxFinite,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFEBEBF4),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color(0xFFEBEBF4),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 200,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color(0xFFE4E4F4),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
