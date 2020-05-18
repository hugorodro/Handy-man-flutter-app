
class Product {
  final int id;
  final String name;
  final String price;
  final String specs;
  final int numInPack;
  final String url;
  final int vendor;

  Product(
      {this.id,
      this.name,
      this.price,
      this.specs,
      this.numInPack,
      this.url,
      this.vendor});

  

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      specs: json['specs'],
      numInPack: json['numInPack'],
      url: json['url'],
      vendor: json['vendor'],
    );
  }
}

 

