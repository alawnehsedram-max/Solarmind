import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const SolarMindApp());
}

class SolarMindApp extends StatelessWidget {
  const SolarMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SolarMind',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String weatherTemp = "جاري التحميل...";
  String weatherLocation = "";
  bool isLoading = false;

  final String baseUrl = "http://10.0.2.2:8000";

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  Future<void> getWeather() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse('$baseUrl/weather'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          weatherTemp = "${data['temperature_celsius']} °C";
          weatherLocation = data['location'];
        });
      } else {
        setState(() {
          weatherTemp = "خطأ في الاستجابة";
        });
      }
    } catch (e) {
      setState(() {
        weatherTemp = "تعذر الاتصال بالسيرفر";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SolarMind - جنين'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'حالة الطقس الحالية',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          weatherLocation.isEmpty ? 'جنين' : weatherLocation,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            weatherTemp,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: getWeather,
              icon: const Icon(Icons.refresh),
              label: const Text('تحديث البيانات'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
