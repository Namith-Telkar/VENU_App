class User {
  String name;
  String email;
  String picture;

  User({
    required this.name,
    required this.email,
    required this.picture,
  });

  void changeName(String newName) {
    name = newName;
  }
}
