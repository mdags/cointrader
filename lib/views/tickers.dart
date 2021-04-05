import 'package:cointrader/controllers/favorites_controller.dart';
import 'package:cointrader/controllers/tickers_controller.dart';
import 'package:cointrader/helpers/variables.dart';
import 'package:cointrader/models/favorites_model.dart';
import 'package:cointrader/models/favorites_ticker_model.dart';
import 'package:cointrader/models/tickers_model.dart';
import 'package:cointrader/services/remote_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class TickersPage extends StatefulWidget {
  final String exchange;

  TickersPage({this.exchange});

  @override
  _TickersPageState createState() => _TickersPageState();
}

class _TickersPageState extends State<TickersPage> {
  final FavoritesController favoritesController =
      Get.put(FavoritesController());
  int columns = 2;
  bool isLoading = true;
  var list = List<TickersModel>();

  void fetchData() async {
    try {
      var data = await RemoteServices.fetchTickers(widget.exchange);
      if (data != null) {
        list = data;
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variables.kPrimaryColor,
      appBar: AppBar(
        title: Text('Tickers'),
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
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : StaggeredGridView.countBuilder(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    key: ObjectKey(columns),
                    crossAxisCount: columns,
                    itemCount: list.length,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    itemBuilder: (context, index) {
                      return cardItem(list[index]);
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1)),
          ),
        ],
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
        children: <Widget>[
          Row(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    favoritesController.addData(FavoritesModel(
                        marketIdentifier: item.market.identifier,
                        coinId: item.coinId,
                        coinName: item.base,
                        target: item.target));
                  },
                  splashColor: Variables.kFourColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star_outline,
                        color: Colors.white,
                        size: 32.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Variables.kFourColor,
                    onTap: () {},
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(item.base + ' / ' + item.target,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Text(item.trustScore),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Trust Score: " + item.trustScore.toString(),
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 11.0)),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(item.last.toStringAsFixed(8),
                              style: TextStyle(color: Colors.grey[400])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
