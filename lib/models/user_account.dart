class UserAccount {
  String? client;
  String? memNo;
  String? idNo;
  String? phone;
  String? altPhone;
  String? sex;
  String? age;
  String? occupation;
  String? residential;
  String? operationArea;
  String? amount;
  String? balance;
  String? createdAt;
  String? updatedAt;

  UserAccount(
      {this.client,
      this.memNo,
      this.idNo,
      this.phone,
      this.altPhone,
      this.sex,
      this.age,
      this.occupation,
      this.residential,
      this.operationArea,
      this.amount,
      this.balance,
      this.createdAt,
      this.updatedAt});

  UserAccount.fromJson(Map<String, dynamic> json) {
    client = json['client'];
    memNo = json['memNo'];
    idNo = json['idNo'];
    phone = json['phone'];
    altPhone = json['alt_phone'];
    sex = json['sex'];
    age = json['age'];
    occupation = json['occupation'];
    residential = json['residential'];
    operationArea = json['operation_area'];
    amount = json['amount'];
    balance = json['balance'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client'] = this.client;
    data['memNo'] = this.memNo;
    data['idNo'] = this.idNo;
    data['phone'] = this.phone;
    data['alt_phone'] = this.altPhone;
    data['sex'] = this.sex;
    data['age'] = this.age;
    data['occupation'] = this.occupation;
    data['residential'] = this.residential;
    data['operation_area'] = this.operationArea;
    data['amount'] = this.amount;
    data['balance'] = this.balance;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
