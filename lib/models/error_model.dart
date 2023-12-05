class GotError {
  String? cod;
  String? message;

  GotError({this.cod, this.message});

  GotError.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cod'] = cod;
    data['message'] = message;
    return data;
  }
}
