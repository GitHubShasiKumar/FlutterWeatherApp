import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/weather_model.dart';
import '../../services/Boredservices.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    BoredService boredService = BoredService();
    on<WeatherEvent>((event, emit) async {
      try {
        if (event is FindWeather) {
          emit(WeatherLoading());
          Weather responce =
              await boredService.getBoredActivity(event.placename);
          emit(WeatherLoaded(responce));
        }
        if (event is GoIntial) {
          emit(WeatherInitial());
        }
      } catch (e) {
        emit(WeatherError());
      }
    });
  }
}
