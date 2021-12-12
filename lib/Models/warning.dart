import 'package:http/http.dart' as http;
import 'dart:convert';
Future<VirusCase> getJson(http.Client client) async{
  final res = await client.get(Uri.parse("https://opendata.cwb.gov.tw/api/v1/rest/datastore/W-C0033-001?Authorization=CWB-EDE00A65-CA8D-48E6-B85C-E2895E317484"));
  return VirusCase.fromjson(jsonDecode(res.body));
}

class VirusCase{
  final List local;
  //final String url;
  const VirusCase({
    required this.local,
    //required this.url
  });

  factory VirusCase.fromjson(Map<String,dynamic> datas){
    return VirusCase(
      local: datas["records"]["location"] ,
      //url: datas["records"]["record"][0]["datasetInfo"]["validTime"]["endTime"] 
    );
  }    
}