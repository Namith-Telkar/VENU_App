class VenuUser {
  String personality;
  String twitter;
  Map location;
  String personalityDescription;
  int credits;
  Map suggestions;

  VenuUser({
    required this.personality,
    required this.twitter,
    required this.location,
    required this.personalityDescription,
    required this.credits,
    required this.suggestions,
  });

  static VenuUser fromNetworkMap(Map<String, dynamic> map) {
    return VenuUser(
      personality: map['personality'] ?? 'Not set',
      twitter: map['twitter'] ?? 'Not set',
      location: map['location'] ?? {},
      personalityDescription: map['personalityDescription'] ?? 'Not set',
      credits: map['tokens'] ?? 0,
      suggestions: map['suggestions'] ?? {},
    );
  }
}
