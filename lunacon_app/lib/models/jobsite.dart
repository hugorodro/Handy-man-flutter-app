class JobSite {
  final int id;
  final String name;
  final String address;
  final String code;

  JobSite({this.id, this.address, this.code, this.name});

  factory JobSite.fromJson(Map<String, dynamic> json) {
    return JobSite(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      code: json['code'],
    );
  }
}
