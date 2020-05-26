class ResponseModel<T> {
  String message;
  String status;
  T data;

  ResponseModel({this.message, this.status, this.data});
}
