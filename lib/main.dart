

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/warning.dart';
import 'package:flutter/foundation.dart';

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
      home: const MyHomePage(title: '天氣'),
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
        backgroundColor: Colors.black,
        title: Text(widget.title,),
      ),
      body: FutureBuilder<VirusCase>(
        future: getJson(http.Client()),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return const Center(child: Text('Error'),);
          }else if(snapshot.hasData){
            
            return RefreshIndicator(
              onRefresh: ()=>getJson(http.Client()),
              child: ListView.builder(
                itemCount: snapshot.data!.local.length,
                itemBuilder: (context,index){
                  var temp=snapshot.data!.local[index]["hazardConditions"]["hazards"];
                  return ListTile(
                    onTap: (){},
                    title: Text(snapshot.data!.local[index]["locationName"]),
                    subtitle: temp.length!=0? Text(temp[0]["info"]["phenomena"]):null,
                  );
                },
              ),
            );
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        }),       
    );
  }
}

