// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:autowheelweb/Components/fullscreen.dart';
import 'package:autowheelweb/Components/menuController.dart';
import 'package:autowheelweb/Utils/Colors.dart';
import 'package:autowheelweb/Utils/dummy.dart';
import 'package:autowheelweb/Utils/mediaquery.dart';
import 'package:autowheelweb/onboarding/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 @override
  Widget build(BuildContext context) {
    Sizes.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auto Wheel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.colPrimary),
        useMaterial3: false,
      ),
       home: MultiProvider(
        providers: [
          ChangeNotifierProvider<Classvaluechange>(
              create: (_) => Classvaluechange()),
          ChangeNotifierProvider(create: (context) => MenuControlle())
        ],
        child:  FullScreen(),
      ),
    );
  }
}

class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final List<String> _chatHistory = [];
  final TextEditingController _messageController = TextEditingController();
  final Map<String, String> _responses = {
    'hello': 'Hi there! How can I help you today?',
    'how are you': 'I\'m doing well, thanks for asking. How are you?',
    'goodbye': 'It was nice chatting with you. Goodbye!',
    'what can you do': 'I can answer simple questions and engage in basic conversation.',
    'anything else': 'I\'m still under development, but I\'m learning new things every day!',
  };

  void _sendMessage() {
    final message = _messageController.text.trim().toLowerCase();
    if (message.isNotEmpty) {
      setState(() {
        _chatHistory.add('You: $message');
        _messageController.clear();
      });

      final response = _responses[message];
      if (response != null) {
        _chatHistory.add('Chatbot: $response');
      } else {
        _chatHistory.add('Chatbot: Sorry, I don\'t understand what you mean.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Stack( // Use Stack for overlapping elements
        children: [
          // Chat history list
          Positioned(
            top: 0, // Align top
            left: 0, // Align left
            right: 0, // Full width
            bottom: 50, // Leave space for text field and button
            child: ListView.builder(
              reverse: false, // Show latest messages at the top
              itemCount: _chatHistory.length,
              itemBuilder: (context, index) => Text(
                _chatHistory[index],
                style: TextStyle(fontSize: 16), // Adjust font size
                textAlign: TextAlign.left, // Align messages to the left
              ),
            ),
          ),

          // Text field and button
          Positioned(
            bottom: 0, // Align bottom
            left: 0, // Align left
            right: 0, // Full width
            height: 50, // Set height for input area
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key,required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
// late List data = [] ;

//   Future<String> getData() async {
//    http.Response? response = await http.get(Uri.parse("http://lms.muepetro.com/api/UserController1/GetLocation"));
// if (response != null && response.statusCode == 200) {
//         // headers: {"Accept": "application/json"}
        
//     setState(() {
//       data = json.decode( response.body);
//     });
//     return "Success";
//   }
//   else 
//   {
//     log("Error");
//   }
//     return "Error";
//    }

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Flutter Api Example"),
//       ),
//       body: Center(
//         child: getList()
//       ),
//     );
//   }

//   Widget getList() {
//     if (data == null || data.length < 1) {
//       return Container(
//         child: Center(
//           child: Text("Please wait..."),
//         ),
//       );
//     }
//     return ListView.separated(
//       itemCount: data!.length,
//       itemBuilder: (BuildContext context, int index) {
//         return getListItem(index);
//       },
//       separatorBuilder: (context, index) {
//         return Divider();
//       },
//     );
//   }

//   Widget? getListItem(int i) {
//     if (data == null || data.length < 1) return null;
//     if (i == 0) {
//       return Container(
//         margin: EdgeInsets.all(4),
//         child: Center(
//           child: Text(
//             "Titles",
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       );
//     }

//     return Container(
//       child: Container(
//         margin: EdgeInsets.all(4.0),
//         child: Padding(
//           padding: EdgeInsets.all(4),
//           child: Text(
//             data[i]['location_Name'].toString(),
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//       ),
//     );
//   }

// }