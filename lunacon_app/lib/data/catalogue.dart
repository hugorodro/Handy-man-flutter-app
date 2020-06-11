import 'package:lunacon_app/models/product.dart';

import 'package:lunacon_app/data/network.dart';

List<Product> _catalogueAlpha = [];

Future<List<Product>> alphaSort() async {
  _catalogueAlpha = await fetchProducts();
  _catalogueAlpha.sort((a, b) => a.name.compareTo(b.name));
  return _catalogueAlpha;
}

Future<List<Product>> searchSort(String userInput) async {
  List<Product> _searchedCatalogue =[];
  _catalogueAlpha.forEach((element) {
    if(element.name.toLowerCase().contains(userInput.toLowerCase())==true){
      _searchedCatalogue.add(element);
    }
  }); 
  print(_searchedCatalogue.length);
  return _searchedCatalogue;
}

