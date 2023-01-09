import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_app/utils/fontDesign.dart';
import 'package:transparent_image/transparent_image.dart';

import 'fullScreen.dart';

class AboutMan extends StatelessWidget {
  final String imagePre = 'https://image.tmdb.org/t/p/w500';
  final List detail;
  final String work;
  final String name;
  final String popularity;
  final String profile_path;
  const AboutMan(
      {super.key,
      required this.detail,
      required this.work,
      required this.name,
      required this.popularity,
      required this.profile_path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 320,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              profile_path,
              fit: BoxFit.cover,
            ),
          ),

          DesignTF(
              text: name != null ? 'Name:  $name' : 'Loading..',
              color1: Colors.white,
              size: 17),

          DesignTF(
              text: popularity != null
                  ? 'Polulartiy:  $popularity B'
                  : 'Loading..',
              color1: Colors.white,
              size: 17),
          Container(
            height: 370,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () {
                    print("before calll=======");
                    print("detail ${detail[index]}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FullScreen(
                                name: detail[index]['original_title'] != null
                                    ? detail[index]['original_title']
                                    : "loading",
                                des: detail[index]['overview'],
                                bannerUrl:
                                    'https://image.tmdb.org/t/p/w500${detail[index]['backdrop_path']}',
                                posterurl:
                                    'https://image.tmdb.org/t/p/w500${detail[index]['poster_path']}',
                                vote: detail[index]['vote_average'].toString(),
                                launch:
                                    detail[index]['release_date'].toString())));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 190,
                                width: 150,
                                child: Stack(
                                  children: [
                                    Center(child: CircularProgressIndicator()),
                                    FadeInImage.memoryNetwork(
                                        height: 180,
                                        fadeInDuration:
                                            Duration(milliseconds: 600),
                                        placeholder: kTransparentImage,
                                        image:
                                            "$imagePre${detail[index]['poster_path']}")
                                  ],
                                )),
                            Container(
                              child: Flexible(
                                child: Text(
                                  detail[index]['overview'] != null
                                      ? detail[index]['overview'].length > 200
                                          ? '${detail[index]['overview'].substring(0, 200)}...'
                                          : detail[index]['overview']
                                      : ' loading..',
                                  //   detail[index]['overview'].substring(0, 40)
                                ),
                              ),
                            ),
                          ],
                        ),
                        DesignTF(
                            text:
                                'Movie Name:  ${detail[index]['original_title']}',
                            color1: Colors.white,
                            size: 12),
                        DesignTF(
                            text:
                                'Release Date:  ${detail[index]['release_date']}',
                            color1: Colors.white,
                            size: 12),
                        DesignTF(
                            text: 'Vote : ${detail[index]['vote_average']}',
                            color1: Colors.white,
                            size: 12),
                      ],
                    ),
                  ),
                );
              }),
              itemCount: detail.length,
            ),
          )

          // Container(
          //   height: 400,
          //   child: ListView.builder(
          //     scrollDirection: Axis.vertical,
          //     itemBuilder: (context, index) {
          //       return Container(
          //         child: Text('Naveen'),
          //       );
          //     },
          //     itemCount: 30,
          //   ),
          // )
        ]),
      ),
    );
  }
}
