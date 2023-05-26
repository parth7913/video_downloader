import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:video_downloader/screen/HomeScreen/model/YouTubeModel.dart';
class ApiHelper
{
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();


  Future<YouTubeModel?> SearchYoutube({required String search})
  async {
    print("===== $search");
    String apiLink = "https://simple-youtube-search.p.rapidapi.com/search?query=$search&safesearch=false";
    var response = await http.get(Uri.parse(apiLink),headers: {
      "X-RapidAPI-Key" : "2c167b7304msha5d7ce4a31dc3c1p1c8a95jsn386562b13e9c",
      "X-RapidAPI-Host" : "simple-youtube-search.p.rapidapi.com",
    });
    print("===== ${response.statusCode}");
    if(response.statusCode == 200)
      {
        var json = jsonDecode(response.body);
        print("======== JSON $json");
        YouTubeModel youTubeData = YouTubeModel.fromJson(json);
        print("===== $youTubeData");
        return youTubeData;
      }
    else
      {
        return null;
      }

  }
}