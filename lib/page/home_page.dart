import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../utils.dart';
import 'onboarding_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: selectedIndex,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: black,
          title: Text(
            "Dashboard",
            style: GoogleFonts.montserrat(
              color: white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', false);
                // ignore: use_build_context_synchronously
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnBoarding(),
                    ));
              },
              icon: const Icon(
                Icons.logout,
                size: 24.0,
                color: white,
              ),
            ),
          ],
        ),
        bottomNavigationBar: FlashyTabBar(
          selectedIndex: selectedIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              icon: const Icon(Icons.event),
              title: const Text('Events'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.search),
              title: const Text('Search'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.highlight),
              title: const Text('Highlights'),
            ),
          ],
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: [
            Row(
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: SizedBox(
                    width: 300,
                    child: TabBar(
                      tabs: const [
                        Tab(
                          text: "Home",
                        ),
                        Tab(
                          text: "Work",
                        ),
                        Tab(
                          text: "Play",
                        ),
                      ],
                      labelColor: Colors.black,
                      // add it here
                      indicator: DotIndicator(
                        color: Colors.black,
                        distanceFromCenter: 16,
                        radius: 3,
                        paintingStyle: PaintingStyle.fill,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(left: 20),
                    height: 300,
                    width: double.maxFinite,
                    child: TabBarView(
                      children: [
                        Container(
                          color: Colors.red[100],
                        ),
                        Container(
                          color: Colors.green[100],
                        ),
                        Container(
                          color: Colors.blue[100],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.red[100],
            ),
            Container(
              color: Colors.green[100],
            ),
          ],
        ),
      ),
    );
  }
}
