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
    _wf.currentWeatherByCityName("Enter the city name ").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: size.height * 0.99,
            width: size.width,
            margin: const EdgeInsets.only(right: 12 , left: 12),
            padding: const EdgeInsets.all(70.0),
            child: SafeArea(child: _buildUI()),
            decoration:  BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                  colors:[
                    Color(0xFF0D47A1),
                    Color(0xFF01597B),
                  ],
                begin:  Alignment.bottomCenter,
                end: Alignment.topCenter,


            ),
          )
          )],
      )


    );
  }

  Widget _buildUI() {
    final Size size = MediaQuery.sizeOf(context); // Extracted the [MediaQuery] in a variable to avoid repeated code to make it readable and clean
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
            SizedBox(height: size.height * 0.95),
            _dateTimeInfo(),
            SizedBox(height: size.height * 0.05),
            _weatherIcon(),
            SizedBox(height: size.height * 0.05),
            _currentTemperature(),
            SizedBox(height: size.height * 0.05),
            _additionalInformation(),
            SizedBox(height: size.height * 0.07),
          ]),
          // Fix: missing brackets ')' and commas ',' after every sizedBox widget.
    );
  }

  Widget _locationHeader() {
    return Text(_weather?.areaName ?? "",
      style: const TextStyle(
        fontSize:34,
        fontWeight: FontWeight.w600,


      )
    );
  }
  Widget _dateTimeInfo(){
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("hh:mm a").format(now),
          style : const TextStyle(
          fontSize:32,
          ),
        ),
        const SizedBox(
          height:3,
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
              "  ${DateFormat("yMMMd").format(now)}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
    )],

        )],
        );
    
  }
  Widget _weatherIcon(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width:150,
          height:200,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("https://openweathermap.org/img/wn/10d@2x.png")),
          ),
        ),
        Text(
            _weather?.weatherDescription ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize:29,
          ),
        ),
      ],
      
      
    );
    
  }
  Widget _currentTemperature() {
    return Text("${_weather?.temperature?.celsius?.toStringAsFixed(0)}`C",
    style: const TextStyle(
      color:Colors.white,
      fontSize:22,
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
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            Text(
                " Minimum Temperature: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}`C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ))
          ],
        ));
  }
}