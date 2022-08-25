import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'bloc/weather_bloc.dart';

class HomeParent extends StatefulWidget {
  const HomeParent({Key? key}) : super(key: key);

  @override
  State<HomeParent> createState() => _HomeParentState();
}

class _HomeParentState extends State<HomeParent> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => WeatherBloc(), child: Home());
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WeatherBloc weatherBloc = BlocProvider.of(context); //
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Weather checker'),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if (state is WeatherInitial) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Lottie.asset('assets/4802-weather-snow-sunny.json'),
                Card(
                  child: TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                        labelText: 'Enter city',
                        hintText: 'Enter city'),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      print(cityController.text);
                      weatherBloc..add(FindWeather(cityController.text));
                    },
                    child: Text("Search"),
                  ),
                ),
                SizedBox(
                  height: 100 + MediaQuery.of(context).viewPadding.bottom,
                ),
              ],
            ),
          );
        } else if (state is WeatherLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is WeatherLoaded) {
          return Center(
            child: Container(
              color: Color.fromARGB(255, 189, 233, 253),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: Text(
                      "Temp:- ${state.model.main.temp}",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.lightBlue,
                  ),
                  Card(
                      child: Text(
                        "FeelsLike:- ${state.model.main.feelsLike}",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.lightBlue),
                  Card(
                      child: Text(
                        "TempMin:- ${state.model.main.tempMin}",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.lightBlue),
                  Card(
                      child: Text(
                        "TempMax:- ${state.model.main.tempMax}",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.lightBlue),
                  Card(
                      child: Text(
                        "Pressure:- ${state.model.main.pressure}",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.lightBlue),
                  Card(
                      child: Text(
                        "Humidity:- ${state.model.main.humidity}",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.lightBlue),
                  ElevatedButton(
                      onPressed: () {
                        weatherBloc..add(GoIntial());
                      },
                      child: Text('Search Again'))
                ],
              ),
            ),
          );
        } else if (state is WeatherError) {
          return Container(
            width: double.infinity,
            color: Color(0xffFFFFFF),
            child: Column(
              children: [
                Text("Something went wrong"),
                ElevatedButton(
                    onPressed: () {
                      weatherBloc..add(GoIntial());
                    },
                    child: Text('Search Again'))
              ],
            ),
          );
        }
        return Container();
      }),
      backgroundColor: Color.fromARGB(31, 29, 28, 28),
    );
  }
}
