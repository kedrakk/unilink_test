import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:uni_links/uni_links.dart';

class LinTestPage extends StatefulWidget {
  const LinTestPage({ Key? key }) : super(key: key);

  @override
  _LinTestPageState createState() => _LinTestPageState();
}

class _LinTestPageState extends State<LinTestPage> {
  String url="";String streamurl="";

  Future<void> initUniLinks() async {
    try {
      final initialLink = await getInitialLink();
      url=initialLink??"no link found";
    } on PlatformException {
      url="Platform exception";
    }
    setState(() {});
  }

  @override
    void initState() {
      initUniLinks();
      super.initState();
      linkStream.listen((event) {
        setState(() {
          streamurl=event!;          
        });
      }).onError((e){
        setState(() {
          streamurl=e.toString();          
        });
      });
    }

    @override
      void dispose() {
        super.dispose();
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Unilink test"),),
      body: Center(
        child: Column(children: [
          Text("init url:$url"),
          Text("Listened url:$streamurl")
        ],),
      ),
    );
  }
}