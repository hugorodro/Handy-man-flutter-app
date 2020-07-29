class Order {
  int id;
  String date;
  bool fulfilled;
  int user;
  List<dynamic> products;
  int jobSite;

  Order(
      {this.id,
      this.date,
      this.fulfilled,
      this.user,
      this.products,
      this.jobSite});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        date: json['date'],
        fulfilled: json['fulfilled'],
        user: json['user'],
        jobSite: json['jobSite'],
        products: json['products']);
  }

  String getStatus() {
    if (fulfilled == false) {
      return "Pending Order";
    } else {
      return "Ordered";
    }
  }

  int getJobSite() {
    return jobSite;
  }
}
