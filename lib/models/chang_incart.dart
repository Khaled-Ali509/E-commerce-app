class ChangInCartModel {
  late bool status;
  late String message;
  ChangInCartModel.fromJson(Map<String , dynamic>json)
  {
    status=json['status'];
    message=json['message'];
  }


}
