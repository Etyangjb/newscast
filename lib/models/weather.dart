import 'package:flutter/material.dart';

class WeatherModel {
  @required
  final String city;
  final List<WeatherQuality>? quality;
  final List<WeatherDescription> description;

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'] as String,
      description: List<WeatherDescription>.from(
        json["weather"].map(
          (item) {
            return WeatherDescription(
                condition: item["main"],
                description: item["description"],
                id: item['id']);
          },
        ),
      ).toList(),
    );
  }

  WeatherModel({
    required this.city,
    this.quality,
    required this.description,
  });
}

class WeatherDescription {
  final String condition;
  final String description;
  final int id;

  WeatherDescription(
      {required this.condition, required this.description, required this.id});
}

class WeatherQuality {
  final String temperature;
  final String pressure;

  WeatherQuality({required this.temperature, required this.pressure});
}
