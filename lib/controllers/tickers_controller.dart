import 'package:cointrader/models/favorites_ticker_model.dart';
import 'package:cointrader/models/tickers_model.dart';
import 'package:cointrader/services/remote_services.dart';
import 'package:get/state_manager.dart';

class TickersController extends GetxController {
  var isLoading = true.obs;
  //var exchange = 'binance'.obs;
  var list = List<TickersModel>().obs;
  var favTickerList = List<FavoritesTickersModel>().obs;

  void fetchData(String exchange) async {
    try {
      isLoading(true);
      var data = await RemoteServices.fetchTickers(exchange);
      if (data != null) {
        list.assignAll(data);
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchDataByCoinId(String exchange, String coinId, String target) async {
    try {
      isLoading(true);
      var data = await RemoteServices.fetchTickerByCoinId(exchange, coinId);
      if (data != null) {
        data.forEach((element) {
          if (element.target == target) {
            favTickerList.add(element);
            print(element);
          }
        });
      }
    } finally {
      isLoading(false);
    }
  }
}
