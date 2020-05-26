class Token{
  final String tokenStr;
  final dynamic id;

  Token({this.tokenStr, this.id});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      tokenStr: json['token'],
      id: json['id']
    );
  }
}