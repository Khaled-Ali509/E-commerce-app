class HomeModel
{
  late bool status;
  DataModel? data;
  HomeModel.fromJson(Map<String , dynamic>json)
  {
    status=json['status'];
    data = json['data']!= null?DataModel.fromJson(json['data']):null;

  }
}

class DataModel
{
  List<BannerModel>banners=[];
  List<ProductModel>products=[];

  DataModel.fromJson(Map<String , dynamic>json)
  {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }

}
class BannerModel
{
  int? id;
  String? image;
  BannerModel.fromJson(Map<String , dynamic>json)
  {
    id = json['id'];
    image=json['image'];
  }
}

class ProductModel
{
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  late bool inFavorite;
  late bool inCart;

  ProductModel.fromJson(Map<String , dynamic>json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name =json['name'];
    inFavorite = json['in_favorites'];
    inCart = json['in_cart'];
  }

}