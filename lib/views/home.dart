import 'package:cointrader/views/alarm.dart';
import 'package:cointrader/views/portfolio.dart';
import 'package:cointrader/views/wallet.dart';
import 'package:cointrader/helpers/variables.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    AlarmPage(),
    PortfolioPage(),
    WalletPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Text('Coin Trader by Mehmet Dagdeviren'),
      // ),
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        color: Variables.kPrimaryColor,
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: _currentIndex,
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.alarm_on_outlined),
              title: showIndicator('Alarm', _currentIndex == 0),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart_outlined),
              title: showIndicator('Portföy', _currentIndex == 1),
            ),
            new BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                title: showIndicator('Cüzdan', _currentIndex == 2)
            ),
          ],
        ),
      ),
    );
  }

  Widget showIndicator(String label, bool show) {
    return show ? Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        children: [
          Text(label),
          Divider(
            color: Colors.white,
            thickness: 4.0,
            indent: 20.0,
            endIndent: 20.0,
          ),
          //Icon(Icons.brightness_1, size: 10, color: Colors.white)
        ],
      ),
    ) : new Text(label);
  }
}
