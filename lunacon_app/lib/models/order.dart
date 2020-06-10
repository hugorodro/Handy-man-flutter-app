class Order {
  int id;
  int quantity;
  String date;
  bool fulfilled;
  int user;
  int product;
  int jobSite;

  Order(
      {this.id,
      this.quantity,
      this.date,
      this.fulfilled,
      this.user,
      this.product,
      this.jobSite});

  factory Order.fromJson(Map<String, dynamic> json) {
   return Order( 
      id : json['id'],
      quantity :  json['quantity'],
      date : json['date'],
      fulfilled : json['fulfilled'],
      user : json['user'],
      product : json['product'],
      jobSite : json['jobSite'],
   );}
}