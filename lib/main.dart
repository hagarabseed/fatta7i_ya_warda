import 'dart:math';
import 'package:flutter/material.dart';
import 'dice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Play Dice',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: const DiceScreen(),
    );
  }
}

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  int value1 = 1;
  int value2 = 1;
  int total = 2;
  String imagePath = 'assets/sad.png';

  void roll() {
    setState(() {
      value1 = Random().nextInt(6) + 1;
      value2 = Random().nextInt(6) + 1;
      total = value1 + value2;

      if (total >= 10) {
        imagePath = 'assets/happy.png';
      } else {
        imagePath = 'assets/sad.png';
      }
    });
  }

  void reset() {
    setState(() {
      value1 = 1;
      value2 = 1;
      total = 2;
      imagePath = 'assets/sad.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play Dice'),
        centerTitle: true,
        leading: const Icon(Icons.casino_outlined),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Total is $total',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),

            // Win / Lose condition text indicator
            Text(
              total >= 10 ? 'YOU WIN, the Rose bloooooomed' : 'YOU LOSE, the rose has closed',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: total >= 10 ? Colors.greenAccent : Colors.redAccent,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Center(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[800],
                      alignment: Alignment.center,
                      child: Text(
                        '[$imagePath]',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Dice(value: value1),
                Dice(value: value2),
              ],
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: roll,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('ROLL'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: reset,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('RESET'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}