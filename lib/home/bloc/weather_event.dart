part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class FindWeather extends WeatherEvent {
  String placename;
  FindWeather(this.placename);
}

class GoIntial extends WeatherEvent {}
