import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/constants/colors.dart';

class profile extends StatefulWidget {
  const profile({
    super.key,
  });

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

//,required this.detailModel
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 10, top: 28),
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage("asset/images/pic2.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "User_name",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: dark_Brown),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "Gender",
                      style: TextStyle(fontSize: 17.0, color: medium_Brown),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      "Age",
                      style: TextStyle(fontSize: 17.0, color: medium_Brown),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Image.asset(
                          "asset/images/coin.png",
                          scale: 4,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          "220",
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: dark_Brown),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: TabBar(
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.brown,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.brown,
              isScrollable: true,
              controller: _tabController,
              tabs: const [
                Tab(
                  child: Text(
                    'My quotes',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Tab(
                  child: Text(
                    'Favourite book',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Tab(
                  child: Text(
                    'Favourite quotes',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Tab(
                  child: Text(
                    'My notes',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Stack(
                  children: [
                    ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 30),
                          child: Container(
                            decoration: BoxDecoration(
                                color: offwhite,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Light_Brown,
                                    offset: const Offset(0, 5),
                                    blurRadius: 10,
                                    // spreadRadius: 10,
                                  )
                                ]),
                            height: 140,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  children: [
                    ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 30),
                          child: Container(
                            decoration: BoxDecoration(
                                color: offwhite,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Light_Brown,
                                    offset: const Offset(0, 5),
                                    blurRadius: 10,
                                    // spreadRadius: 10,
                                  )
                                ]),
                            height: 140,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                    // AddComment()
                  ],
                ),
                Stack(
                  children: [
                    ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 30),
                          child: Container(
                            decoration: BoxDecoration(
                                color: offwhite,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Light_Brown,
                                    offset: const Offset(0, 5),
                                    blurRadius: 10,
                                    // spreadRadius: 10,
                                  )
                                ]),
                            height: 140,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                    // AddComment()
                  ],
                ),
                Stack(
                  children: [
                    ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 30),
                          child: Container(
                            decoration: BoxDecoration(
                                color: offwhite,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Light_Brown,
                                    offset: const Offset(0, 5),
                                    blurRadius: 10,
                                    // spreadRadius: 10,
                                  )
                                ]),
                            height: 140,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                    // AddComment()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
