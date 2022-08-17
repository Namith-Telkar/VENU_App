class VenuUser {
  String personality;
  String twitter;
  Map location;

  VenuUser({
    required this.personality,
    required this.twitter,
    required this.location,
  });


  static VenuUser fromNetworkMap(Map<String, dynamic> map) {
    return VenuUser(
      personality: map['personality'] ?? 'Not set',
      twitter: map['twitter'] ?? 'Not set',
      location: map['location'] ?? 'Not set',
    );
  }
}