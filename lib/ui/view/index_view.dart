import 'dart:io';
import 'package:apps.technical.sera_astra/ui/view/account_view.dart';
import 'package:apps.technical.sera_astra/ui/view/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constant/app_color.dart';
import '../widget/fab_bottom_app_bar.dart';
import '../widget/fade_route.dart';
import 'base_view.dart';
import 'home_view.dart';

GlobalKey<NavigatorState> mainNavigatorKey = GlobalKey<NavigatorState>();

class IndexView extends StatefulWidget {
  @override
  _IndexViewState createState() => _IndexViewState();
}

class _IndexViewState extends State<IndexView> {
  int _selectedTabIndex = 0;

  void _selectedTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }


  final _listPage = <Widget>[
    HomeView(),
    CartView(),
    AccountView(),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return (await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    "Keluar",
                  ),
                  content: const Text(
                    "Apakah anda yakin ingin keluar dari aplikasi?",
                  ),
                  actions: [
                    TextButton(
                      child: const Text("Batal"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text(
                        "Keluar",
                      ),
                      onPressed: () {
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else if (Platform.isIOS) {
                          exit(0);
                        }
                      },
                    ),
                  ],
                ),
              )) ??
              false;
        },
        child: Center(
          child: _listPage[_selectedTabIndex],
        ),
      ),
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.black54,
        selectedColor: colorPrimary,
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(
            iconData: const AssetImage(
              "assets/icons/Nav Bar - Home (Aktif).png",
            ),
            text: 'Home',
          ),
          FABBottomAppBarItem(
              iconData: const AssetImage(
                "assets/images/logo1.png",
              ),
              text: 'My Cart'),
          FABBottomAppBarItem(
            iconData: const AssetImage(
              "assets/icons/Nav Bar - Akun (Aktif).png",
            ),
            text: 'Akun',
          ),
        ],
      ),
    );
  }
}
