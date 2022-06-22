class BatteryStation {
  String? location;
  String? description;
  int? chargedBattery;
  int? dischargedBattery;
  String? date;
  String? getImage;

  BatteryStation(
      {this.location,
      this.description,
      this.chargedBattery,
      this.dischargedBattery,
      this.date,
      this.getImage});

  BatteryStation.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    description = json['description'];
    chargedBattery = json['charged_battery'];
    dischargedBattery = json['discharged_battery'];
    date = json['date'];
    getImage = json['getImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['description'] = this.description;
    data['charged_battery'] = this.chargedBattery;
    data['discharged_battery'] = this.dischargedBattery;
    data['date'] = this.date;
    data['getImage'] = this.getImage;
    return data;
  }
}
