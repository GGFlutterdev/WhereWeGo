import 'dart:convert';

City cityFromJson(String str) => City.fromJson(json.decode(str) as Map<String, dynamic>);

String cityToJson(City data) => json.encode(data.toJson());

class City {
    City({
      required this.country,
      required this.name,
      required this.lat,
      required this.lng,
    });

    String country;
    String name;
    double lat;
    double lng;

    factory City.fromJson(Map<String, dynamic> json) => City(
        country: json["country"].toString(),
        name: json["name"].toString(),
        lat: double.parse(json["lat"].toString()),
        lng: double.parse(json["lng"].toString()),
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "name": name,
        "lat": lat,
        "lng": lng,
    };
}
