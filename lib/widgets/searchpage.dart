import 'package:flutter/material.dart';
import 'package:movie_app/utils/fontDesign.dart';
import 'package:movie_app/widgets/fullScreen.dart';
import 'package:transparent_image/transparent_image.dart';

class SerachPage extends StatelessWidget {
  final List search_list;
  final String imagePre = 'https://image.tmdb.org/t/p/w500';
  const SerachPage({super.key, required this.search_list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: (() {
                String name, des, posteurl, bannerurl, launch, vote;
                name = search_list[index]['original_title'] != null
                    ? search_list[index]['original_title']
                    : 'Loading..';
                des = search_list[index]['overview'] != null
                    ? search_list[index]['overview']
                    : 'Loading..';
                launch = search_list[index]['release_date'] != null
                    ? search_list[index]['release_date']
                    : 'Loading..';
                vote = search_list[index]['vote_average'] != null
                    ? search_list[index]['vote_average'].toString()
                    : 'Loading..';
                posteurl = search_list[index]['poster_path'] != null
                    ? '$imagePre${search_list[index]['poster_path']}'
                    : '${imagePre}2v3pC01rf0uXnECOM94pjfqk1TYo';
                bannerurl = search_list[index]['backdrop_path'] != null
                    ? '$imagePre${search_list[index]['backdrop_path']}'
                    : '${imagePre}2v3pC01rf0uXnECOM94pjfqk1TYm';

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FullScreen(
                            name: name,
                            des: des,
                            bannerUrl: bannerurl,
                            posterurl: posteurl,
                            vote: vote,
                            launch: launch)));
              }),
              child: Container(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Center(child: CircularProgressIndicator()),
                            FadeInImage.memoryNetwork(
                                height: 200,
                                fadeInDuration: Duration(milliseconds: 400),
                                placeholder: kTransparentImage,
                                image:
                                    '$imagePre${search_list[index]['backdrop_path']}')
                          ],
                        ),
                        // child: Image.network(
                        //     '$imagePre${search_list[index]['backdrop_path']}'),
                      ),
                      Container(
                        height: 20,
                        child: DesignTF(
                          text:
                              "${search_list[index]['original_title'] != null ? search_list[index]['original_title'] : 'Loading'}",
                          size: 15,
                          color1: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
            );
          }),
          itemCount: search_list.length,
        ),
      ),
    );
  }
}
