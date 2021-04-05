// To parse this JSON data, do
//
//     final tickersModel = tickersModelFromJson(jsonString);

import 'dart:convert';

List<TickersModel> tickersModelFromJson(String str) => List<TickersModel>.from(json.decode(str).map((x) => TickersModel.fromJson(x)));

String tickersModelToJson(List<TickersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TickersModel {
    TickersModel({
        this.base,
        this.target,
        this.market,
        this.last,
        this.volume,
        this.convertedLast,
        this.convertedVolume,
        this.trustScore,
        this.bidAskSpreadPercentage,
        this.timestamp,
        this.lastTradedAt,
        this.lastFetchAt,
        this.isAnomaly,
        this.isStale,
        this.tradeUrl,
        this.tokenInfoUrl,
        this.coinId,
        this.targetCoinId,
    });

    String base;
    String target;
    Market market;
    double last;
    double volume;
    Map<String, double> convertedLast;
    Map<String, double> convertedVolume;
    String trustScore;
    double bidAskSpreadPercentage;
    DateTime timestamp;
    DateTime lastTradedAt;
    DateTime lastFetchAt;
    bool isAnomaly;
    bool isStale;
    String tradeUrl;
    dynamic tokenInfoUrl;
    String coinId;
    String targetCoinId;

    factory TickersModel.fromJson(Map<String, dynamic> json) => TickersModel(
        base: json["base"],
        target: json["target"],
        market: Market.fromJson(json["market"]),
        last: json["last"].toDouble(),
        volume: json["volume"].toDouble(),
        convertedLast: Map.from(json["converted_last"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        convertedVolume: Map.from(json["converted_volume"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        trustScore: json["trust_score"],
        bidAskSpreadPercentage: json["bid_ask_spread_percentage"].toDouble(),
        timestamp: DateTime.parse(json["timestamp"]),
        lastTradedAt: DateTime.parse(json["last_traded_at"]),
        lastFetchAt: DateTime.parse(json["last_fetch_at"]),
        isAnomaly: json["is_anomaly"],
        isStale: json["is_stale"],
        tradeUrl: json["trade_url"],
        tokenInfoUrl: json["token_info_url"],
        coinId: json["coin_id"],
        targetCoinId: json["target_coin_id"],
    );

    Map<String, dynamic> toJson() => {
        "base": base,
        "target": target,
        "market": market.toJson(),
        "last": last,
        "volume": volume,
        "converted_last": Map.from(convertedLast).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "converted_volume": Map.from(convertedVolume).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "trust_score": trustScore,
        "bid_ask_spread_percentage": bidAskSpreadPercentage,
        "timestamp": timestamp.toIso8601String(),
        "last_traded_at": lastTradedAt.toIso8601String(),
        "last_fetch_at": lastFetchAt.toIso8601String(),
        "is_anomaly": isAnomaly,
        "is_stale": isStale,
        "trade_url": tradeUrl,
        "token_info_url": tokenInfoUrl,
        "coin_id": coinId,
        "target_coin_id": targetCoinId,
    };
}

class Market {
    Market({
        this.name,
        this.identifier,
        this.hasTradingIncentive,
    });

    String name;
    String identifier;
    bool hasTradingIncentive;

    factory Market.fromJson(Map<String, dynamic> json) => Market(
        name: json["name"],
        identifier: json["identifier"],
        hasTradingIncentive: json["has_trading_incentive"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "identifier": identifier,
        "has_trading_incentive": hasTradingIncentive,
    };
}
