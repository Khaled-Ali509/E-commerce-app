class SearchModel
{
   bool? status;
   dynamic message;
   Data? data;
  SearchModel.fromJson(Map<String , dynamic>json)
  {
    status= json['status'];
    message= json['message'];
    data = json['data'] !=null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
   List<ProductDetails> data=[];
 Data.fromJson(Map<String , dynamic>json)
 {
   json['data'].forEach((element) {
     data.add(ProductDetails.fromJson(element));
   });
 }
}

class ProductDetails {
  int? id;
  dynamic price;
  String? image;
  String? name;
  String? description;
  List<String> images=[];
  late bool inFavorites;
  late bool inCart;

  ProductDetails.fromJson(Map<String, dynamic>json)
  {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    json['images'].forEach((element) {
      images.add(element);
    });
  }
}