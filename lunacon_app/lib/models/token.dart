class Token{
  final String tokenStr;
  final dynamic userId;

  Token({this.tokenStr, this.userId});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      tokenStr: json['token'],
      userId: json['id']
    );
  }
}