class Battery {
  int? id;
  String? code;
  String? location;
  String? status;
  String? condition;

  Battery({this.id, this.code, this.location, this.status, this.condition});

  Battery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    location = json['location'];
    status = json['status'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['location'] = this.location;
    data['status'] = this.status;
    data['condition'] = this.condition;
    return data;
  }
}
