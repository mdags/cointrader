import 'package:cointrader/helpers/variables.dart';
import 'package:cointrader/models/tickers_model.dart';
import 'package:cointrader/services/data_services.dart';
import 'package:cointrader/services/remote_services.dart';
import 'package:cointrader/views/exchanges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  int columns = 2;
  var favTickerList = List<TickersModel>();

  Future<void> fetchFavorites() async {
    var list = List<TickersModel>();
    try {
      var data = await DataBaseServices.instance.getFavorites();
      if (data != null) {
        data.forEach((favorite) async {
          var rdata = await RemoteServices.fetchFavorites(
              favorite.marketIdentifier, favorite.coinId);
          rdata.forEach((ticker) {
            if (ticker.target == favorite.target) {
              setState(() {
                list.add(ticker);
              });
            }
          });
        });
      }
    } finally {
      setState(() {
        favTickerList = list;
      });
    }
  }

  @override
  void initState() {
    fetchFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variables.kPrimaryColor,
      appBar: AppBar(
        title: Text('Coin Trader mdags7'),
        actions: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius:
                  BorderRadius.circular(AppBar().preferredSize.height),
              child: Icon(
                columns == 1 ? Icons.dashboard : Icons.view_agenda,
                color: Variables.kSecondaryColor,
              ),
              onTap: () {
                setState(() {
                  columns = columns == 2 ? 1 : 2;
                });
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StaggeredGridView.countBuilder(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                key: ObjectKey(columns),
                crossAxisCount: columns,
                // itemCount: favoritesController.list.length,
                itemCount: favTickerList.length,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                itemBuilder: (context, index) {
                  // return Container(
                  //   height: 200,
                  //   width: 100,
                  //   color: Variables.kThirdColor,
                  //   child: Center(
                  //     child: Text(favoritesController.list[index].coinName),
                  //   ),
                  // );
                  return cardItem(favTickerList[index]);
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Variables.kSecondaryColor,
        child: Icon(Icons.addchart_outlined),
        onPressed: () => Get.to(
          ExchangesPage(),
          fullscreenDialog: true,
        ),
      ),
    );
  }

  Widget cardItem(TickersModel item) {
    return Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Variables.kSecondaryColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          new BoxShadow(
            offset: Offset(-2.0, 2.0),
            color: Variables.kFourColor,
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(item.base + ' / ' + item.target,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              Text(item.trustScore),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Trust Score: " + item.trustScore.toString(),
                style: TextStyle(color: Colors.grey[400], fontSize: 11.0)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(item.last.toStringAsFixed(8),
                style: TextStyle(color: Colors.grey[400])),
          ),
        ],
      ),
    );
  }
}
