import 'package:flutter/material.dart';
import 'package:xmw_shop/widgets/InvitationAllListWidget.dart';
import 'package:xmw_shop/widgets/InvitationListWidget.dart';

class TestPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<TestPage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Colors.white),
      child: Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            title: Text("首页"),
          ),
          body: NestedScrollView(
              controller: _scrollViewController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    leading: Offstage(
                      child: IconButton(
                          icon: Image.asset(' '),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                    pinned: true,
                    floating: true,
                    expandedHeight: 280,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: Container(
                        //头部整个背景颜色
                        height: double.infinity,
                        color: Color(0xffcccccc),
                        child: Column(
                          children: <Widget>[
                            _buildBanner(),
                            _buildButtons(),
                            _buildTabBarBg()
                          ],
                        ),
                      ),
                    ),
                    bottom: TabBar(
                        controller: _tabController,
                        unselectedLabelColor: Colors.red,
                        labelColor: Colors.green,
                        tabs: [
                          Container(
                            child: Tab(text: "aaa"),
                          ),
                          Tab(text: "bbb"),
                          Tab(text: "ccc"),
                        ]),
                  )
                ];
              },
              body: TabBarView(controller: _tabController, children: [

                _buildListView("ccc:"),
              ]))),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
      height: 144,
    );
  }

  //banner下面的按钮
  Widget _buildButtons() {
    return Expanded(
      child: Row(
        children: <Widget>[
          _buildButtonItem(Icons.chat, "xxxx"),
          Image.asset("assets/images/phone_flow_chart_arrow.png", height: 8),
          _buildButtonItem(Icons.pages, "xxxx"),
          Image.asset("assets/images/phone_flow_chart_arrow.png", height: 8),
          _buildButtonItem(Icons.phone_android, "xxxx"),
          Image.asset("assets/images/phone_flow_chart_arrow.png", height: 8),
          _buildButtonItem(Icons.print, "xxxx"),
        ],
      ),
    );
  }

  Widget _buildButtonItem(IconData icon, String text) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, size: 28.0),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: Text(text,
              style: TextStyle(color: Color(0xff999999), fontSize: 12)),
        )
      ],
    ));
  }

  Widget _buildTabBarBg() {
    return Container(
      //TabBar圆角背景颜色
      height: 50,
      child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: Container(color: Colors.white)),
    );
  }

  Widget _buildListView(String s) {
    return ListView.separated(
        itemCount: 20,
        separatorBuilder: (BuildContext context, int index) => Divider(
              color: Colors.grey,
              height: 1,
            ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
              color: Colors.white,
              child: ListTile(title: Text("$s第$index 个条目")));
        });
  }
}
