import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController controllerText = TextEditingController();
   FlutterTts _flutterTts = FlutterTts();

  String? language;
  String? newVoiceText;
  bool isPlaying = false;


  Future _speak(String newVoiceText) async {
    if(controllerText.toString().isNotEmpty){
      await _flutterTts.speak(newVoiceText);
      await _flutterTts.setVolume(2);
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
     print(await _flutterTts.getLanguages);
      print(await _flutterTts.getVoices);
    }
  }

  Future _stop() async {
    await _flutterTts.stop();
    setState(() {
      isPlaying = false;
    });
  }

    void initializeTts(){
    _flutterTts.setStartHandler(() {
      setState(() {
        isPlaying = true;
      });
    });
    _flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });

    _flutterTts.setErrorHandler((message) {
      setState(() {
        isPlaying = false;
      });
    });
    }
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeTts();
  }
   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _flutterTts.stop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Text to Speech"),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextField(
              controller: controllerText,
              decoration: InputDecoration(
                hintText: "Enter the text"
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
               isPlaying? _stop() : _speak(controllerText.text.toString());
              },
              child: Text(isPlaying? "Stop" : "Speak"),
            )
          ],
        ),
      ),
    );
  }
}
