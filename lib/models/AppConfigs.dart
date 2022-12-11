class AppConfigs {
  Uri feedbackFormUrl;
  int appVersion;
  Map personalityDescriptions;
  Map venueTypes;
  Uri appLink;

  AppConfigs({
    required this.feedbackFormUrl,
    required this.appVersion,
    required this.personalityDescriptions,
    required this.venueTypes,
    required this.appLink,
  });

  static AppConfigs fromNetworkMap(Map<String, dynamic> map) {
    return AppConfigs(
      feedbackFormUrl: Uri.parse(map['feedbackFormLink']),
      appVersion: map['appVersion'],
      personalityDescriptions: map['personalityDescriptions'],
      venueTypes: map['venueTypes'],
      appLink: Uri.parse(map['appLink']),
    );
  }
}
