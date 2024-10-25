import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:random_user/models/random_user.dart';

class RandomUserScreen extends StatefulWidget {
  const RandomUserScreen({super.key});

  @override
  State<RandomUserScreen> createState() => _RandomUserScreenState();
}

class _RandomUserScreenState extends State<RandomUserScreen> {
  RandomUser? randomUser;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random User'),
        backgroundColor: Colors.blueGrey[100],
        centerTitle: true,
      ),
      body: (randomUser == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage:
                          NetworkImage(randomUser!.results.first.picture.large),
                    ),
                  ),
                  Text(
                    '${randomUser!.results[0].name.first} ${randomUser!.results[0].name.last}',
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.email),
                      const SizedBox(width: 10),
                      Text(
                        randomUser!.results[0].email,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 10),
                      Text(
                        '${randomUser!.results[0].location.city}, ${randomUser!.results[0].location.country}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(width: 10),
                      Text(
                        randomUser!.results[0].phone,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cake),
                      const SizedBox(width: 10),
                      Text(
                        randomUser!.results[0].dob.date
                            .toString()
                            .substring(0, 10),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fetchData();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void fetchData() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/'));
    if (response.statusCode == 200) {
      setState(() {
        randomUser = randomUserFromJson(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
}
