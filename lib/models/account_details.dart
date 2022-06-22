class AccountDetails {
  String? client;
  String? balance;
  String? accLevel;
  String? starcoins;
  String? firstname;
  String? lastname;
  String? username;
  String? status;
  String? date;

  AccountDetails(
      {this.client,
      this.balance,
      this.accLevel,
      this.starcoins,
      this.firstname,
      this.lastname,
      this.username,
      this.status,
      this.date});

  AccountDetails.fromJson(Map<String, dynamic> json) {
    client = json['client'];
    balance = json['balance'];
    accLevel = json['accLevel'];
    starcoins = json['starcoins'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    username = json['username'];
    status = json['status'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client'] = this.client;
    data['balance'] = this.balance;
    data['accLevel'] = this.accLevel;
    data['starcoins'] = this.starcoins;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['username'] = this.username;
    data['status'] = this.status;
    data['date'] = this.date;
    return data;
  }
}
