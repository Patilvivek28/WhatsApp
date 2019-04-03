import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/pages/camera.dart';
import 'package:whatsapp/pages/chats.dart';
import 'package:whatsapp/pages/calls.dart';
import 'package:whatsapp/pages/status.dart';

class WhatsAppHome extends StatefulWidget {
  WhatsAppHome(this.analytics, this.observer);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _WhatsAppHomeState createState() => _WhatsAppHomeState(analytics, observer);
}

class _WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  _WhatsAppHomeState(this.analytics, this.observer);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 1, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp"),
        elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: null),
          IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: null)
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[Camera(), Chats(), Status(), Calls()],
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return FloatingActionButton(
            child: Icon(
              Icons.chat,
              color: Colors.white,
            ),
            onPressed: () {
              final snackBar = SnackBar(content: Text('Send a new message'));
              Scaffold.of(context).showSnackBar(snackBar);
            });
      }),
    );
  }
}
