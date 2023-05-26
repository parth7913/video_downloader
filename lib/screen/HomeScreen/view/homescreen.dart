import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader/screen/HomeScreen/model/YouTubeModel.dart';
import 'package:video_downloader/screen/HomeScreen/provider/HomeProvider.dart';
import 'package:video_downloader/utils/ApiHelper.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeProvider? providerTrue;
  HomeProvider? providerFalse;
  @override
  Widget build(BuildContext context) {
    providerTrue = Provider.of<HomeProvider>(context,listen: true);
    providerFalse = Provider.of<HomeProvider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Video Downloader"),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30,right: 15,left: 15),
              child: TextField(
                controller: providerTrue!.txtSearch,
                decoration: InputDecoration(
                  hintText: "Search Youtube Content!",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if(providerFalse!.txtSearch.text.isNotEmpty)
                        {
                          providerFalse!.SearchVideo();
                        }
                    },
                    icon: const Icon(Icons.search),
                  )
                ),
              ),
            ),
            providerTrue!.search.isNotEmpty
                ? Expanded(
                  child: FutureBuilder<YouTubeModel?>(
              future: ApiHelper.apiHelper.SearchYoutube(search: providerTrue!.search.isEmpty ? "carryminati" : providerTrue!.search),
              builder: (context, snapshot) {
                  if(snapshot.hasError)
                    {
                      return Center(child: Text("${snapshot.error}"),);
                    }
                  else if(snapshot.hasData)
                    {
                      providerTrue!.youTubeModel = snapshot.data;
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: providerTrue!.youTubeModel!.results!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          print("==== ${providerTrue!.youTubeModel!.results![0].url}");
                          return Padding(
                            padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                            child: InkWell(
                              onTap: () {
                                providerFalse!.AddValue(data: providerFalse!.youTubeModel!.results![index]);
                                providerFalse!.LoadVideo();
                                Navigator.pushNamed(context, 'D');
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network(providerTrue!.youTubeModel!.results![index].thumbnail!.url!,fit: BoxFit.fill,)),
                                    ),
                                  ),
                                  SizedBox(height: 3,),
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 18,
                                      backgroundImage: NetworkImage(providerTrue!.youTubeModel!.results![index].channel!.icon!),
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    title: Text("${providerTrue!.youTubeModel!.results![index].title}",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                    subtitle: Text(
                                        "${providerTrue!.youTubeModel!.results![index].channel!.name} • ${providerTrue!.youTubeModel!.results![index].views! > 999 && providerTrue!.youTubeModel!.results![index].views! < 99999 ? "${(providerTrue!.youTubeModel!.results![index].views! / 1000) .toStringAsFixed(1)} K" : providerTrue!.youTubeModel!.results![index].views! > 99999 && providerTrue!.youTubeModel!.results![index].views! < 999999 ? "${(providerTrue!.youTubeModel!.results![index].views! / 1000) .toStringAsFixed(0)} K" : providerTrue!.youTubeModel!.results![index].views! > 999999 && providerTrue!.youTubeModel!.results![index].views! < 999999999 ? "${(providerTrue!.youTubeModel!.results![index].views! / 1000000) .toStringAsFixed(1)} M" : providerTrue!.youTubeModel!.results![index].views! > 999999999 ? "${(providerTrue!.youTubeModel!.results![index].views! / 1000000000) .toStringAsFixed(1)} B" : providerTrue!.youTubeModel!.results![index].views!} views • ${providerTrue!.youTubeModel!.results![index].uploadedAt}",
                                        maxLines: 1,overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  return const Center(child: CircularProgressIndicator(),);
              },
            ),
                )
                : const Expanded(child: Center(child: Text("Please Search Youtube Content!"),))
          ],
        ),
      ),
    );
  }
}
