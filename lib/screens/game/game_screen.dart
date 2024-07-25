import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/screens/game/result_screen.dart';
import 'package:http/http.dart' as http;

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<dynamic> cards = [];
  List<dynamic> shuffledImages = [];
  List<dynamic> shuffledWords = [];
  List<bool>? imageMatched;
  List<bool>? wordMatched;
  int? selectedImageIndex;
  int? selectedWordIndex;
  int countIncorrect = 0;

  void fetchCard() async {
    const url =
        'https://datn-quan-ly-hoc-tap.vercel.app/api/content/task/list?courseID=bzLT&unitID=qN39';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final cardData = data.firstWhere((item) => item['taskNo'] == 1,
            orElse: () => {'contentData': []});
        final cardContent =
            cardData['content'][0]['contentData'] as List<dynamic>;

        setState(() {
          cards = cardContent;
          shuffledImages = List.from(cards)..shuffle();
          shuffledWords = List.from(cards)..shuffle();
          imageMatched = List.generate(cards.length, (_) => false);
          wordMatched = List.generate(cards.length, (_) => false);
        });
      } else {
        print('Failed to load cards');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCard();
  }

  void checkMatch() {
    if (selectedImageIndex != null && selectedWordIndex != null) {
      if (shuffledImages[selectedImageIndex!]['word'] ==
          shuffledWords[selectedWordIndex!]['word']) {
        setState(() {
          imageMatched![selectedImageIndex!] = true;
          wordMatched![selectedWordIndex!] = true;
          selectedImageIndex = null;
          selectedWordIndex = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Good job!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ));

        if (imageMatched!.every((matched) => matched) &&
            wordMatched!.every((matched) => matched)) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Congratulations! You found all matches.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResultScreen(countIncorrect)));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Incorrect Match! Try Again.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ));
        setState(() {
          selectedImageIndex = null;
          selectedWordIndex = null;
          countIncorrect = countIncorrect + 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 223, 223, 223),
        title: const Text("Matching Game"),
      ),
      body: cards.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  flex: 2,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: shuffledImages.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImageIndex = index;
                          });
                          checkMatch();
                        },
                        child: Card(
                          color: imageMatched![index]
                              ? Colors.grey[300]
                              : (selectedImageIndex == index
                                  ? Colors.blue[100]
                                  : Colors.white),
                          child: imageMatched![index]
                              ? SizedBox.expand(
                                  child: Center(
                                    child: Image.network(
                                      shuffledImages[index]['image'],
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(Icons.error);
                                      },
                                    ),
                                  ),
                                )
                              : SizedBox.expand(
                                  child: Center(
                                    child: Image.network(
                                      shuffledImages[index]['image'],
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(Icons.error);
                                      },
                                    ),
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.0,
                    ),
                    itemCount: shuffledWords.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedWordIndex = index;
                          });
                          checkMatch();
                        },
                        child: Card(
                          color: wordMatched![index]
                              ? Colors.green[300]
                              : (selectedWordIndex == index
                                  ? Colors.blue[100]
                                  : Colors.white),
                          child: Center(
                            child: Text(
                              utf8.decode(latin1.encode(
                                  shuffledWords[index]['word'].toString())),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
