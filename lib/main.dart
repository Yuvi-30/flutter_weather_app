
import 'package:flutter/material.dart';
import 'weather_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? weatherData;
  bool isLoading = false;

  void fetchWeatherData(String city) async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await _weatherService.fetchWeather(city);
      print(data);  // Check if data is received
      setState(() {
        weatherData = data;
        isLoading = false;
      });
      print(weatherData);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4C688B), // Light bluish-grey with 50% transparency
        elevation: 0,
        title: const Text('Weather App'),
      ),
      body: SingleChildScrollView(

        child: Container(
          decoration: BoxDecoration(color: Color(0xFF1B263B)),
          child: Column(
            children: [

              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF4C688B), // Slightly lighter blue
                      Color(0xFF3A5A80), // Medium steel blue
                      Color(0xFF1B263B), // Dark blue to match top
                    ],
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(
                              top: 20.0, left: 10.0, right: 16.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: TextField(
                              controller: _controller,
                              decoration:  InputDecoration(
                                labelText: 'Enter city',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.yellow),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //const SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_controller.text.isNotEmpty) {
                                fetchWeatherData(_controller.text);
                              }
                            },
                            child: const Text('Get Weather'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60),
                    if (isLoading)  Center(child: CircularProgressIndicator()),
                    if (weatherData != null)
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Text(
                                  '${weatherData!['name']}',
                                  style: const TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                                 SizedBox(height: 8),
                                Text(
                                  '${weatherData!['main']['temp']}°C',
                                  style: const TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                                 SizedBox(height: 8),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 140,
                            height: 0,
                          ),
                          Column(
                            children: [
                              Text('image'),
                              Text(
                                '${weatherData!['weather'][0]['description']}',

                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft, // Gradient starts from top-left
                        end: Alignment.bottomRight, // Gradient ends at bottom-right
                        colors: [
                          Color(0x80D1DCE5), // Light bluish-grey
                          Color(0x80BCC4C9), // Muted grey
                          Color.fromRGBO(211, 211, 211, 0.2), // Light grey with transparency
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Humidity',
                            )),
                        SizedBox(
                          height: 0,
                          width: 220,
                        ),
                        Text(
                          '${weatherData!['main']['humidity']}',
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft, // Gradient starts from top-left
                        end: Alignment.bottomRight, // Gradient ends at bottom-right
                        colors: [
                          Color(0x80D1DCE5), // Light bluish-grey
                          Color(0x80BCC4C9), // Muted grey
                          Color.fromRGBO(211, 211, 211, 0.2), // Light grey with transparency
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('pressure')),
                        SizedBox(
                          height: 0,
                          width: 220,
                        ),
                        Text('${weatherData!['main']['pressure']}°C',)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft, // Gradient starts from top-left
                        end: Alignment.bottomRight, // Gradient ends at bottom-right
                        colors: [
                          Color(0x80D1DCE5), // Light bluish-grey
                          Color(0x80BCC4C9), // Muted grey
                          Color.fromRGBO(211, 211, 211, 0.2), // Light grey with transparency
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('humidity')),
                        SizedBox(
                          height: 0,
                          width: 220,
                        ),
                        Text('value')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft, // Gradient starts from top-left
                        end: Alignment.bottomRight, // Gradient ends at bottom-right
                        colors: [
                          Color(0x80D1DCE5), // Light bluish-grey
                          Color(0x80BCC4C9), // Muted grey
                          Color.fromRGBO(211, 211, 211, 0.2), // Light grey with transparency
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('humidity')),
                        SizedBox(
                          height: 0,
                          width: 220,
                        ),
                        Text('value')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft, // Gradient starts from top-left
                        end: Alignment.bottomRight, // Gradient ends at bottom-right
                        colors: [
                          Color(0x80D1DCE5), // Light bluish-grey
                          Color(0x80BCC4C9), // Muted grey
                          Color.fromRGBO(211, 211, 211, 0.2), // Light grey with transparency
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('humidity')),
                        SizedBox(
                          height: 0,
                          width: 220,
                        ),
                        Text('value'),

                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
