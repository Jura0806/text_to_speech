

import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';


class Speak {

   FlutterTts flutterTts = FlutterTts();
   String? language;
   String? newVoiceText;

   Future _speak(text) async{
     var result = await flutterTts.speak(text);

   }


}