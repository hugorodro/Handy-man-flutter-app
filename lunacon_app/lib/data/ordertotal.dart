
calcCost(intList, productList){
  double aSum = 0 ;
  for (var i = 0; i<intList.length; i++){
    aSum = intList[i]*productList[i].price;
  }
  return aSum;
  
}