// To parse this JSON data, do
//
//     final exchangesModel = exchangesModelFromJson(jsonString);

import 'dart:convert';

List<ExchangesModel> exchangesModelFromJson(String str) => List<ExchangesModel>.from(json.decode(str).map((x) => ExchangesModel.fromJson(x)));

String exchangesModelToJson(List<ExchangesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExchangesModel {
    ExchangesModel({
        this.id,
        this.name,
        this.yearEstablished,
        this.country,
        this.description,
        this.url,
        this.image,
        this.hasTradingIncentive,
        this.trustScore,
        this.trustScoreRank,
        this.tradeVolume24HBtc,
        this.tradeVolume24HBtcNormalized,
    });

    String id;
    String name;
    int yearEstablished;
    String country;
    String description;
    String url;
    String image;
    bool hasTradingIncentive;
    int trustScore;
    int trustScoreRank;
    double tradeVolume24HBtc;
    double tradeVolume24HBtcNormalized;

    factory ExchangesModel.fromJson(Map<String, dynamic> json) => ExchangesModel(
        id: json["id"],
        name: json["name"],
        yearEstablished: json["year_established"],
        country: json["country"],
        description: json["description"],
        url: json["url"],
        image: json["image"],
        hasTradingIncentive: json["has_trading_incentive"],
        trustScore: json["trust_score"],
        trustScoreRank: json["trust_score_rank"],
        tradeVolume24HBtc: json["trade_volume_24h_btc"].toDouble(),
        tradeVolume24HBtcNormalized: json["trade_volume_24h_btc_normalized"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "year_established": yearEstablished,
        "country": country,
        "description": description,
        "url": url,
        "image": image,
        "has_trading_incentive": hasTradingIncentive,
        "trust_score": trustScore,
        "trust_score_rank": trustScoreRank,
        "trade_volume_24h_btc": tradeVolume24HBtc,
        "trade_volume_24h_btc_normalized": tradeVolume24HBtcNormalized,
    };
}
