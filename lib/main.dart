

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
Future<VirusCase> getJson(http.Client client) async{
  final res = await client.get(Uri.parse("https://opendata.cwb.gov.tw/api/v1/rest/datastore/W-C0033-002?Authorization=CWB-EDE00A65-CA8D-48E6-B85C-E2895E317484"));
  return VirusCase.fromjson(jsonDecode(res.body));
}

class VirusCase{
  final String title;
  final String url;
  const VirusCase({
    required this.title,
    required this.url
  });

  factory VirusCase.fromjson(Map<String,dynamic> datas){
    return VirusCase(
      title: datas["records"]["record"][0]["datasetInfo"]["datasetDescription"] ,
      url: datas["records"]["record"][0]["datasetInfo"]["validTime"]["endTime"] 
    );
  }    
}
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<VirusCase>(
        future: getJson(http.Client()),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return const Center(child: Text('Error'),);
          }else if(snapshot.hasData){
            
            return ListView.builder(
              itemCount: 20,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(snapshot.data!.title),
                );
              },
            );
          }else{
            return const CircularProgressIndicator();
          }
        }),       
    );
  }
}

