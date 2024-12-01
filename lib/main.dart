import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hagen Translator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Hagen App',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 40),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // button color
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    'Log in',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to ProfileScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('Translation'),
                subtitle: Text('Translate text between different languages'),
                trailing: Icon(Icons.translate),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TranslatorScreen()),
                  );
                },
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text('Contact'),
                subtitle: Text('Get in touch with us'),
                trailing: Icon(Icons.contact_phone),
                onTap: () {
                  // Navigate to Contact screen
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TranslatorScreen extends StatefulWidget {
  @override
  _TranslatorScreenState createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  TextEditingController _controller = TextEditingController();
  String _translatedText = '';
  final translator = GoogleTranslator(); // Using the translator package

  String _sourceLanguage = 'en'; // Default source language
  String _targetLanguage = 'de'; // Default target language

  bool _showSuggestions = false; // Controls the visibility of suggestions

  // Dummy responses for suggested replies
  final List<String> _suggestedResponses = [
    "Wie Gehts?",
    "Danke!",
    "Guten Tag?",
    "Bis Spater!."
  ];

  void _translateText(String text) async {
    try {
      var translation = await translator.translate(text,
          from: _sourceLanguage, to: _targetLanguage);
      setState(() {
        _translatedText = translation.text;
      });
    } catch (e) {
      setState(() {
        _translatedText = 'Error during translation: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Translator'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to ProfileScreen
              // Replace with your ProfileScreen logic
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Source language dropdown
              DropdownButton<String>(
                value: _sourceLanguage,
                items: [
                  DropdownMenuItem<String>(value: 'en', child: Text('English')),
                  DropdownMenuItem<String>(value: 'de', child: Text('German')),
                  DropdownMenuItem<String>(value: 'fr', child: Text('French')),
                  DropdownMenuItem<String>(value: 'es', child: Text('Spanish')),
                ],
                onChanged: (newLanguage) {
                  setState(() {
                    _sourceLanguage = newLanguage!;
                  });
                },
              ),
              SizedBox(height: 20),
              // Text input for source text
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter text here...',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onChanged: (text) {
                  _translateText(text);
                },
              ),
              SizedBox(height: 20),
              // Target language dropdown
              DropdownButton<String>(
                value: _targetLanguage,
                items: [
                  DropdownMenuItem<String>(value: 'en', child: Text('English')),
                  DropdownMenuItem<String>(value: 'de', child: Text('German')),
                  DropdownMenuItem<String>(value: 'fr', child: Text('French')),
                  DropdownMenuItem<String>(value: 'es', child: Text('Spanish')),
                ],
                onChanged: (newLanguage) {
                  setState(() {
                    _targetLanguage = newLanguage!;
                  });
                },
              ),
              SizedBox(height: 20),
              // Display translated text
              Card(
                elevation: 5,
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    _translatedText.isEmpty
                        ? 'Translation will appear here...'
                        : _translatedText,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Button to toggle suggestions
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showSuggestions = !_showSuggestions;
                  });
                },
                child: Text(_showSuggestions
                    ? 'Hide Suggested Responses'
                    : 'Show Suggested Responses'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
              ),
              SizedBox(height: 20),
              // Suggested responses section
              if (_showSuggestions && _translatedText.isNotEmpty)
                Column(
                  children: _suggestedResponses.map((response) {
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.volume_up, color: Colors.redAccent),
                          onPressed: () {
                            // Placeholder for text-to-speech functionality
                            print("Reading out: $response");
                          },
                        ),
                        title: Text(
                          response,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center horizontally
            children: [
              // Load image from the assets
              CircleAvatar(
                radius: 60,
                backgroundImage:
                    AssetImage('images/cat.jpg'), // Load from assets
              ),
              SizedBox(height: 20),
              Text(
                'abda envi',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Email: abi-is-cool@hagenberg.com',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Country: Pakistan',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Langauges Speaking: Urdu, English, Elvish, Punjabi, Hindko',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
