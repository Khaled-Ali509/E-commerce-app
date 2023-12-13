class InCartModel {
  bool? status;
  String? message;
  Data? data;
   InCartModel.fromJson(Map<String , dynamic>json)
  {
    status=json['status'];
    message=json['message'];
    data=json['data']!= null?Data.fromJson(json['data']):null;
  }

}

class Data {

  List<CartItem> cartItems=[];
  Data.fromJson(Map<String , dynamic>json)
  {
    json['cart_items'].forEach((element) {
      cartItems.add(CartItem.fromJson(element));
    });

  }
  }

class CartItem {
  int? id;
  int? quantity;
  Product? product;

  CartItem.fromJson(Map<String , dynamic>json)
  {
    id=json['id'];
    quantity=json['quantity'];
    product=json['product']!= null?Product.fromJson(json['product']):null;
  }

}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List<String> images=[];
  bool? inFavorites;
  bool? inCart;

  Product.fromJson(Map<String , dynamic>json)
  {
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    description=json['description'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];
    json['images'].forEach((element) {
      images.add(element);
    });



  }
}
