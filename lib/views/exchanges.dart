import 'package:cointrader/controllers/exchanges_controller.dart';
import 'package:cointrader/controllers/tickers_controller.dart';
import 'package:cointrader/models/exchanges_model.dart';
import 'package:cointrader/helpers/variables.dart';
import 'package:cointrader/views/tickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class ExchangesPage extends StatefulWidget {
  @override
  _ExchangesPageState createState() => _ExchangesPageState();
}

class _ExchangesPageState extends State<ExchangesPage> {
  final ExchangesController exchangesController =
      Get.put(ExchangesController());
  final TickersController tickersController = Get.put(TickersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Variables.kPrimaryColor,
      appBar: AppBar(
        title: Text('Exchanges'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (exchangesController.isLoading.value)
                return Center(child: CircularProgressIndicator());
              else
                return StaggeredGridView.countBuilder(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    crossAxisCount: 2,
                    itemCount: exchangesController.exchangeList.length,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    itemBuilder: (context, index) {
                      return cardItemExchanges(
                          exchangesController.exchangeList[index]);
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1));
            }),
          ),
        ],
      ),
    );
  }

  Widget cardItemExchanges(ExchangesModel item) {
    return Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Variables.kSecondaryColor,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          new BoxShadow(
            offset: Offset(-2.0, 2.0),
            color: Variables.kThirdColor,
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Variables.kThirdColor,
          onTap: () => Get.to(
            TickersPage(
              exchange: item.id,
            ),
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(item.name,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  Image.network(item.image),
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
                child: Text(item.tradeVolume24HBtc.toStringAsFixed(8) + " BTC",
                    style: TextStyle(color: Colors.grey[400])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
