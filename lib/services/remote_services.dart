import 'dart:convert';
import 'package:cointrader/models/exchanges_model.dart';
import 'package:cointrader/models/favorites_ticker_model.dart';
import 'package:cointrader/models/tickers_model.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var url = "https://api.coingecko.com/api/v3";
  static var client = http.Client();

  static Future<List<ExchangesModel>> fetchExchanges() async {
    var response = await client.get(url + "/exchanges");
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return exchangesModelFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<List<TickersModel>> fetchTickers(String exchange) async {
    var response =
        await client.get(url + "/exchanges/" + exchange + "/tickers");
    if (response.statusCode == 200) {
      var map = json.decode(response.body) as Map;
      var jsonString = json.encode(map["tickers"]);
      return tickersModelFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<List<TickersModel>> fetchFavorites(
      String exchange, String coinId) async {
    var response = await client
        .get(url + "/exchanges/" + exchange + "/tickers?coin_ids=" + coinId);
    // var response = await client
    //     .get(url + "/coins/" + coinId + "/tickers?exchange_ids=" + exchange);
    if (response.statusCode == 200) {
      var map = json.decode(response.body) as Map;
      var jsonString = json.encode(map["tickers"]);
      return tickersModelFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<List<FavoritesTickersModel>> fetchTickerByCoinId(
      String exchange, String coinId) async {
    // var response = await client
    //     .get(url + "/exchanges/" + exchange + "/tickers?coin_ids=" + coinId);
    var response = await client
        .get(url + "/coins/" + coinId + "/tickers?exchange_ids=" + exchange);
    if (response.statusCode == 200) {
      var map = json.decode(response.body) as Map;
      var jsonString = json.encode(map["tickers"]);
      return favoritesTickersModelFromJson(jsonString);
    } else {
      return null;
    }
  }
}
