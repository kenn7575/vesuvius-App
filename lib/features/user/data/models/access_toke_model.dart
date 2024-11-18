class AccessTokenModel {
  final String accessToken;

  AccessTokenModel({
    required this.accessToken,
  });

  factory AccessTokenModel.fromJson({required Map<String, dynamic> json}) {
    return AccessTokenModel(
      accessToken: json[kAccessToken],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kAccessToken: accessToken,
    };
  }
}

// constants
// these constants are used to map the json data to the model and vice versa
const String kAccessToken = 'accessToken';
