class Token {
  final String tokenStr;
  final dynamic userId;
  final String firstName;
  final String lastName;

  Token({this.tokenStr, this.userId, this.firstName, this.lastName});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      tokenStr: json['token'],
      userId: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name']
    );
  }
}
