class ChangFavoriteModel{

 late bool status;
 late String message;
  ChangFavoriteModel.fromJson(Map<String , dynamic>json)
  {
    status=json['status'];
    message=json['message'];
  }
}