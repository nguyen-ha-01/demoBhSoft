class UserData {
  String username;
  String token;
  String password;

  UserData({
    required this.username,
    required this.token,
    required this.password,
  });

  // Phương thức để chuyển đổi đối tượng User thành Map
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'token': token,
      'password': password,
    };
  }

  void update({
    String? username,
    String? token,
    String? password,
  }) {
    if (username != null) this.username = username;
    if (token != null) this.token = token;
    if (password != null) this.password = password;
  }

  // Phương thức để tạo đối tượng User từ Map
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      username: map['username'],
      token: map['token'],
      password: map['password'],
    );
  }
}
