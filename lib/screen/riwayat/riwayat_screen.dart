import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:simpada/screen/riwayat/transaksi_page.dart';

import 'billing_page.dart';

class RiwayatScreen extends StatefulWidget {

  @override
  _RiwayatScreenState createState() => _RiwayatScreenState();
}

Widget _dash(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  final dashWidth = 10.0;
  final dashCount = (size.width / (2 * dashWidth)).floor();
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Flex(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      direction: Axis.horizontal,
      children: List.generate(dashCount, (_) {
        return SizedBox(
          width: dashWidth,
          height: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.grey),
          ),
        );
      }),
    ),
  );
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  TabBar myTabBar = TabBar(
    labelColor: Colors.black,
    indicator: BoxDecoration(
        color: Color(0xFFD0EEFF),
        border: Border(
          bottom: BorderSide(color: Color(0xFF2F89E8), width: 2),
        )),
    tabs: [
      Tab(
        text: 'Transaksi',
      ),
      Tab(
        text: 'Billing',
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Builder(
          builder: (BuildContext context) {
            final TabController tabController =
            DefaultTabController.of(context);
            tabController.addListener(() {
              // print(tabController);
              if (!tabController.indexIsChanging) {}
            });
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Riwayat',
                  style: TextStyle(
                    fontFamily: 'poppins regluar',
                    fontSize: 14.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Color(0xFF2F89E8),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(myTabBar.preferredSize.height),
                  child: Container(
                    color: Color(0xFFEAF7FF),
                    child: myTabBar,
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  Navigator(
                    onGenerateRoute: (settings) {
                      Widget page = TransaksiPage();
                      // if (settings.name == 'page2') page = SplashScreen();
                      return MaterialPageRoute(builder: (_) => page);
                    },
                  ),
                  Navigator(
                    onGenerateRoute: (settings) {
                      Widget page = BillingPage();
                      return MaterialPageRoute(builder: (_) => page);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

  }
}
// return Scaffold(
// appBar: AppBar(
// backgroundColor: Color(0xFF2E93E1),
// centerTitle: true,
//
// ),