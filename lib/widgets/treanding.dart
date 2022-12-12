import 'package:flutter/material.dart';
import 'package:movie_app/widgets/fullScreen.dart';
import 'package:transparent_image/transparent_image.dart';
import '../utils/fontDesign.dart';

class TrendingMovies extends StatelessWidget {
  final List treanding;
  final String imagePre = 'https://image.tmdb.org/t/p/w500';

  const TrendingMovies({super.key, required this.treanding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DesignTF(text: "Trending movies", color1: Colors.white, size: 20),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullScreen(
                                  name: treanding[index]['title'] != null
                                      ? treanding[index]['title']
                                      : 'Loading',
                                  des: treanding[index]['overview'],
                                  bannerUrl:
                                      'https://image.tmdb.org/t/p/w500${treanding[index]['backdrop_path']}',
                                  posterurl:
                                      'https://image.tmdb.org/t/p/w500${treanding[index]['poster_path']}',
                                  vote: treanding[index]['vote_average']
                                      .toString(),
                                  launch: treanding[index]['release_date']
                                      .toString())));
                    }),
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: 115,
                            height: 160,
                            child: Stack(children: [
                              Center(child: CircularProgressIndicator()),
                              FadeInImage.memoryNetwork(
                                  height: 160,
                                  fadeInDuration: Duration(milliseconds: 400),
                                  placeholder: kTransparentImage,
                                  image:
                                      "$imagePre${treanding[index]['poster_path']}")
                            ]),
                            // decoration: BoxDecoration(
                            //     image: DecorationImage(
                            //         image: NetworkImage(
                            //             "$imagePre${treanding[index]['poster_path']}"))),
                          ),
                          Container(
                              height: 20,
                              child: DesignTF(
                                text: treanding[index]['title'] != null
                                    ? treanding[index]['title']
                                    : 'Loading..',
                                size: 12,
                                color1: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  );
                },
                itemCount: treanding.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
