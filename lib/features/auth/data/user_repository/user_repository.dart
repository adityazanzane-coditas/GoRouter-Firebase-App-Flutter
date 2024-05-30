class UserRepository {
  final List<Map<String, String>> _users = [];

  bool isUserPresent(String username, String password) {
    return _users.any(
        (user) => user['username'] == username && user['password'] == password);
  }

  void registerUser(
      String givenName, String familyName, String username, String password) {
    _users.add({
      'givenName': givenName,
      'familyName': familyName,
      'username': username,
      'password': password,
    });
  }
}
