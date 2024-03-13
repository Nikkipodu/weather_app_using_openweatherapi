import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app_using_openweatherapi/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(openWeatherApiKey);
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Hyderabad").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Added [SafeArea] widget to avoid overlapping with system UI. It helps keep the app from being obscured by system UI and also makes the app not get entangled with the system gestures (if any).
      body: SafeArea(child: _buildUI()),
    );
  }

  Widget _buildUI() {
    final Size size = MediaQuery.sizeOf(context); // Extracted the [MediaQuery] in a variable to avoid repeated code to make it readble and clean
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _locationHeader(),
            SizedBox(height: size.height * 0.09),
            _dateTimeInfo(),
            SizedBox(height: size.height * 0.09),
            _weatherIcon(),
            SizedBox(height: size.height * 0.09),
            _currentTemperature(),
            SizedBox(height: size.height * 0.09),
            _additionalInformation(),
            SizedBox(height: size.height * 0.09),
          ]),
          // Fix: missing brackets ')' and commas ',' after every sizedBox widget.
    );
  }

  Widget _locationHeader() {
    return Text(_weather?.areaName ?? "",
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w600,
        ));
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("hh:mm:ss a").format(now),
          style: const TextStyle(
            fontSize: 35,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "  ${DateFormat("d/m/y").format(now)}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://openweathermap.org/img/wn/${_weather?.weatherIcon}@3x.png")),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(
            color: Colors.black26,
            fontSize: 31,
          ),
        ),
      ],
    );
  }

  Widget _currentTemperature() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}`C",
      style: const TextStyle(
        color: Colors.black12,
        fontSize: 27,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _additionalInformation() {
    final Size size = MediaQuery.sizeOf(context);
    return Container(
        width: size.width,
        // height: size.height * 0.75, // This height was making the UI unresponsive as it was going out of bounds and threw render overflow error.
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(22),
        ),
        padding: const EdgeInsets.all(7.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   mainAxisSize: MainAxisSize.max,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [

            //   ],
            // ),
            Text(
              "Maximum Temperature : ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}`C",
              style: const TextStyle(
                color: Colors.black12,
                fontSize: 15,
              ),
            ),
            Text(
                " Minimum Temperature: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}`C",
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ))
          ],
        ));
  }
}
