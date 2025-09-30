import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String temperature = '';
  String humidity = '';
  String description = '';
  double _currentIndex = 0.0;
  bool isSwitched = false;

  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=10.82302&lon=106.62965&appid=YOUR_API_KEY&units=metric&lang=vi';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          weatherData = data;
          temperature = data['main']['temp'].toString();
          humidity = data['main']['humidity'].toString();
          description = data['weather'][0]['description'];
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GARDEN"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.tree, size: 30, color: Colors.green),
                label: 'Garden 1',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.treeCity, size: 30, color: Colors.blue),
                label: 'Garden 2',
              ),
            ],
            currentIndex: _currentIndex.toInt(),
            onTap: (index) {
              setState(() {
                _currentIndex = index.toDouble();
              });
            },
          ),

          // Thông tin thời tiết
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text('Temperature: $temperature °C',
                    style: const TextStyle(fontSize: 20)),
                Text('Humidity: $humidity %',
                    style: const TextStyle(fontSize: 20)),
                Text('Status: $description',
                    style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),

          // Nút Switch
          Switch(
            value: isSwitched,
            activeColor: Colors.green,
            inactiveThumbColor: Colors.grey,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
              });
            },
          ),

          const SizedBox(height: 10),

          // Nếu muốn hiển thị thêm dữ liệu JSON gốc
          Expanded(
            child: weatherData == null
                ? const Center(child:Text( 'Loading weather data...'))
                : ListView(
                    padding: const EdgeInsets.all(10),
                    children: [
                      Text("City: ${weatherData!['name']}"),
                      Text("Wind speed: ${weatherData!['wind']['speed']} m/s"),
                      Text("Pressure: ${weatherData!['main']['pressure']} hPa"),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
