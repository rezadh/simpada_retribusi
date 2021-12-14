import 'package:flutter/material.dart';
import 'package:simpada/screen/dashboard/dashboard_screen.dart';
import 'package:simpada/screen/generate/generate_page.dart';
import 'package:simpada/screen/generate/daftar_billing_page.dart';
import 'package:simpada/screen/generate/riwayat_penyetoran_page.dart';

class DaftarSetoranScreen extends StatefulWidget {
  const DaftarSetoranScreen({Key key}) : super(key: key);

  @override
  _DaftarSetoranScreenState createState() => _DaftarSetoranScreenState();
}

class _DaftarSetoranScreenState extends State<DaftarSetoranScreen> {
  TabBar myTabBar = TabBar(
    labelColor: Colors.black,
    indicator: BoxDecoration(
        color: Color(0xFFD0EEFF),
        border: Border(
          bottom: BorderSide(color: Color(0xFF2F89E8), width: 2),
        )),
    tabs: [
      Tab(
        child: Text('Generate Billing', maxLines: 2, textAlign: TextAlign.center,),
        // text: 'Generate Billing',
      ),
      Tab(
        text: 'Daftar Billing',
      ),
      Tab(
        child: Text('Riwayat Penyetoran', maxLines: 2, textAlign: TextAlign.center,),
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
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
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 20.0,
                  onPressed: () {
                    _goBack(context);
                  },
                ),
                centerTitle: true,
                title: Text(
                  'Daftar Setoran Retribusi',
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
                      Widget page = GenerateScreen();
                      // if (settings.name == 'page2') page = SplashScreen();
                      return MaterialPageRoute(builder: (_) => page);
                    },
                  ),
                  Navigator(
                    onGenerateRoute: (settings) {
                      Widget page = DaftarBillingPage();
                      return MaterialPageRoute(builder: (_) => page);
                    },
                  ),
                  Navigator(
                    onGenerateRoute: (settings) {
                      Widget page = RiwayatPenyetoranPage();
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
_goBack(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => DashboardScreen()),
  );
}