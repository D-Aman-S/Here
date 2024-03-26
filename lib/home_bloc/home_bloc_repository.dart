import 'dart:convert';

import 'package:hereAssignment/constants/config.dart';
import 'package:hereAssignment/constants/example_forecast_model.dart';
import 'package:hereAssignment/models/fore_cast_data.dart';
import 'package:hereAssignment/models/weather_data.dart';
import 'package:hereAssignment/services/base_api_service.dart';
import 'package:hereAssignment/services/location_service.dart';
import 'package:geocode/geocode.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class HomeBlockRepository {
  HomeBlockRepository() {
    weatherData = WeatherData.fromJson(exampleData);
  }
  // auto location weather data
  num lat = 0;
  num long = 0;
  WeatherData weatherData = WeatherData();
  List<WeatherData> foreCastList = [];
  String city = "";
  List<ForeCastData> foreCastData = [];
  //search city weather data
  WeatherData weatherDataByCIty = WeatherData();
  List<WeatherData> foreCastListByCity = [];
  String searchCity = "";
  List<ForeCastData> forCastValuesCity = [];
  late LocationData locationData;

  loadData() async {
    try {
      await getLoc();
      foreCastList = [];
      foreCastData = [];
      var data = await BaseApiCall.callGet(
          Urls.getUrlBYLocation(city: city, lat: lat, long: long));
      weatherData = WeatherData.fromJson(data);
      var forcastData = await BaseApiCall.callGet(Urls.getdailyForecastUrl(
          lat: weatherData.coord.lat, long: weatherData.coord.lon));
      getForecast(forcastData);
    } catch (e) {
      print(e.toString());
    }
  }

  loadDataByCity({String city = "Varanasi"}) async {
    forCastValuesCity = [];
    foreCastListByCity = [];
    searchCity = city;
    var data = await BaseApiCall.callGet(Urls.getUrl(city: city));
    weatherDataByCIty = WeatherData.fromJson(data);
    var forcastData = await BaseApiCall.callGet(Urls.getdailyForecastUrl(
        lat: weatherDataByCIty.coord.lat, long: weatherDataByCIty.coord.lon));
    getForecastForCity(forcastData);
  }

  Map<String, dynamic> exampleData = {
    "coord": {"lon": 83, "lat": 25.3333},
    "weather": [
      {"id": 721, "main": "Haze", "description": "haze", "icon": "50d"}
    ],
    "base": "stations",
    "main": {
      "temp": 312.2,
      "feels_like": 317.54,
      "temp_min": 312.2,
      "temp_max": 312.2,
      "pressure": 1001,
      "humidity": 37
    },
    "visibility": 4000,
    "wind": {"speed": 4.12, "deg": 290},
    "clouds": {"all": 62},
    "dt": 1687063203,
    "sys": {
      "type": 1,
      "id": 9138,
      "country": "IN",
      "sunrise": 1687045059,
      "sunset": 1687094423
    },
    "timezone": 19800,
    "id": 1253405,
    "name": "Varanasi",
    "cod": 200
  };
  getLoc() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    lat = locationData.latitude!;
    long = locationData.longitude!;
    await getCitiesFromLatLng(locationData.latitude!, locationData.longitude!);
  }

  // getLocationData() async {
  //   LocationService().determinePosition().then((value) {
  //     print(value);
  //     getCitiesFromLatLng(value.latitude, value.longitude);
  //   }).onError((error, stackTrace) {
  //     print("Got error while determining position: $error");
  //   });
  // }

  getCitiesFromLatLng(double latitude, double longitude) async {
    try {
      GeoCode geoCode = GeoCode();
      Address address = await geoCode.reverseGeocoding(
          latitude: latitude, longitude: longitude);
      city = address.city ?? "";
    } on Exception catch (e) {
      print("geocode failed because of: ${e.toString}");
    }
  }

  List<List<int>> colors = [
    [0xffFA7D82, 0xffFFB295],
    [0xff738AE6, 0xff5C5EDD],
    [0xffFE95B6, 0xffFF5287],
    [0xff6F72CA, 0xff1E1466]
  ];
  getForecast(var datas) {
    var data;
    if (datas['list'].length < 4) {
      data = ExampleForeCastModel.data["list"];
    } else {
      data = datas["list"];
    }
    List<String> checkLIst = [];
    for (var i = 5; i < data.length; i++) {
      WeatherData temp = WeatherData.fromJson(data[i]);
      String date = temp.dt_txt.split(' ')[0];
      if (!checkLIst.contains(date)) {
        checkLIst.add(date);
        print(date);
        foreCastList.add(temp);
      }
    }
    if (foreCastList.length >= 4) {
      makeForeCastData();
    }
  }

  makeForeCastData() {
    for (int i = 0; i < 4; i++) {
      foreCastData.add(
        ForeCastData(
          imagePath:
              "https://openweathermap.org/img/wn/${foreCastList[i].weather[0].icon}@2x.png",
          titleTxt: foreCastList[i].weather[0].main,
          temp: foreCastList[i].main.temp,
          date: formatDate(foreCastList[i].dt_txt),
          startColor: colors[i][0],
          endColor: colors[i][1],
        ),
      );
    }
  }

  ///for city search
  getForecastForCity(var datas) {
    var data;
    if (datas['list'].length < 4) {
      data = ExampleForeCastModel.data["list"];
    } else {
      data = datas["list"];
    }
    List<String> checkLIst = [];
    for (var i = 5; i < data.length; i++) {
      WeatherData temp = WeatherData.fromJson(data[i]);
      String date = temp.dt_txt.split(' ')[0];
      if (!checkLIst.contains(date)) {
        checkLIst.add(date);
        print(date);
        foreCastListByCity.add(temp);
      }
    }
    if (foreCastListByCity.length >= 4) {
      makeForeCastDataFOrCity();
    }
  }

  makeForeCastDataFOrCity() {
    for (int i = 0; i < 4; i++) {
      forCastValuesCity.add(
        ForeCastData(
          imagePath:
              "https://openweathermap.org/img/wn/${foreCastListByCity[i].weather[0].icon}@2x.png",
          titleTxt: foreCastListByCity[i].weather[0].main,
          temp: foreCastListByCity[i].main.temp,
          date: formatDate(foreCastListByCity[i].dt_txt),
          startColor: colors[i][0],
          endColor: colors[i][1],
        ),
      );
    }
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateFormat formatter = DateFormat.MMMMEEEEd();
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }
}
