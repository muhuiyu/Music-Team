class TokenModel {
  TokenModel({
    this.userId,
    this.accessToken,
  });

  int? userId;
  String? accessToken;

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        userId: json["userId"],
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "accessToken": accessToken,
      };
}
