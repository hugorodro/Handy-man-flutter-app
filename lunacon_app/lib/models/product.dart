
class Product {
  final int id;
  final String name;
  final String priceEstimate;
  final String specs;
  final int numInPack;
  final String url;
  final int vendor;

  Product(
      {this.id,
      this.name,
      this.priceEstimate,
      this.specs,
      this.numInPack,
      this.url,
      this.vendor});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      priceEstimate: json['price_estimate'],
      specs: json['specs'],
      numInPack: json['numInPack'],
      url: json['url'],
      vendor: json['vendor'],
    );
  }
}

 

