class FavoritesModel {
  int id;
  String marketIdentifier;
  String coinId;
  String coinName;
  String target;

  FavoritesModel(
      {this.id,
      this.marketIdentifier,
      this.coinId,
      this.coinName,
      this.target});

  factory FavoritesModel.fromMap(Map<String, dynamic> json) =>
      new FavoritesModel(
          id: json["id"],
          marketIdentifier: json["marketIdentifier"],
          coinId: json["coinId"],
          coinName: json["coinName"],
          target: json["target"]);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'marketIdentifier': marketIdentifier,
      'coinId': coinId,
      'coinName': coinName,
      'target': target
    };
  }
}
