import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List meals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }

  Future<void> fetchMeals() async {
    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          meals = data['meals'] ?? [];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load meals');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint("Error fetching meals: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : meals.isEmpty
            ? const Center(child: Text("No meals found"))
            : ListView.builder(
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  final meal = meals[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Image.network(
                        meal['strMealThumb'],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 60),
                      ),
                      title: Text(meal['strMeal']),
                      subtitle: Text(meal['strCategory'] ?? 'No Category'),
                    ),
                  );
                },
              );
  }
}
