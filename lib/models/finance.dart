class Transaction {
  String? client;
  String? purpose;
  String? amount;
  String? status;
  String? createdAt;
  String? updatedAt;

  Transaction(
      {this.client,
      this.purpose,
      this.amount,
      this.status,
      this.createdAt,
      this.updatedAt});

  Transaction.fromJson(Map<String, dynamic> json) {
    client = json['client'];
    purpose = json['purpose'];
    amount = json['amount'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client'] = this.client;
    data['purpose'] = this.purpose;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
