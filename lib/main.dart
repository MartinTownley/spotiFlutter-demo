import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:spotify_sdk/models/connection_status.dart';
import 'package:spotify_sdk/models/crossfade_state.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/models/player_context.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _connected = false;

  String text = ""; //to hold the input text

  void changeText(String text) {
    this.setState(() {
      this.text = text;
    });
  } // this function will get called elsewhere, and used to pass text into our homepage class.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hello World')),
      body: Column(children: <Widget>[
        Center(
          child: ElevatedButton(
            onPressed: () {
              print('button clicked');
              //onnectToSpotifyRemote;
            },
            child: Text("Connect"),
          ),
        ),
        TextInputWidget(this.changeText),
        Text(this.text)
      ]),
    );
  }
}

class TextInputWidget extends StatefulWidget {
  final Function(String) callback;

  //constructor:
  TextInputWidget(this.callback);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller =
      TextEditingController(); //can use this controller to access the values of our text field.
  @override
  void dispose() {
    super.dispose(); //disposes of the parent
    controller.dispose();
  }

  void click() {
    //call the callback
    widget.callback(controller.text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: this.controller,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.message),
            labelText: "Type a message:",
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              splashColor: Colors.blue,
              tooltip: "Post message", //displayed on longpress
              onPressed: this.click,
            )));
  }
}

//Connection to Spotify:
// Future<void> connectToSpotifyRemote() async {
//     try {
//       setState(() {
//         _loading = true;
//       });
//       var result = await SpotifySdk.connectToSpotifyRemote(
//           clientId: env['CLIENT_ID'].toString(),
//           redirectUrl: env['REDIRECT_URL'].toString());
//       setStatus(result
//           ? 'connect to spotify successful'
//           : 'connect to spotify failed');
//       setState(() {
//         _loading = false;
//       });
//     } on PlatformException catch (e) {
//       setState(() {
//         _loading = false;
//       });
//       setStatus(e.code, message: e.message);
//     } on MissingPluginException {
//       setState(() {
//         _loading = false;
//       });
//       setStatus('not implemented');
//     }
//   }
