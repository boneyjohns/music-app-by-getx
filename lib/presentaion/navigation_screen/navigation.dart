import 'package:beatboxnew/controller/navigationcontroller.dart';
import 'package:beatboxnew/core/const.dart';
import 'package:beatboxnew/presentaion/home_screen/home.dart';
import 'package:beatboxnew/presentaion/library/library.dart';
import 'package:beatboxnew/presentaion/searchscreen/seachbar.dart';
import 'package:beatboxnew/presentaion/settingsdrawer/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class NavigationPage extends StatelessWidget {
  NavigationPage({super.key});

  // ignore: prefer_final_fields
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    MyHome(),
    Library(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetX<Navigationcontroller>(
        init: Navigationcontroller(),
        builder: (c) {
          return Scaffold(
            drawer: SettingsDrawer(),
            appBar: AppBar(
              backgroundColor: kblack,
              shape: kappbarshape,
              title: Text('BEAT BOX', style: kmaintextstyle),
              centerTitle: true,
              toolbarHeight: 60,
              actions: [
                IconButton(
                    onPressed: () {
                      Get.to(Searchbar());
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
            body: Center(
              child: _widgetOptions.elementAt(c.selectedindex.value),
            ),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(30), right: Radius.circular(30)),
                color: kblack,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GNav(
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      c.bottomChange(index);
                    },
                    backgroundColor: kblack,
                    color: knavbar,
                    activeColor: knavbar,
                    tabBackgroundColor: klightblue,
                    padding: const EdgeInsets.all(10),

                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: [
                      const GButton(
                        icon: Icons.home,
                        text: 'Home',
                        textStyle: TextStyle(fontSize: 20, color: kwhite),
                      ),
                      const GButton(
                        icon: Icons.library_music_rounded,
                        text: 'Library',
                        textStyle: TextStyle(fontSize: 20, color: kwhite),
                      ),
                    ]),
              ),
            ),
          );
        });
  }
}
