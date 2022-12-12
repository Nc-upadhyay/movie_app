import 'package:flutter/material.dart';

import '../utils/fontDesign.dart';
import 'fullScreen.dart';
import 'package:transparent_image/transparent_image.dart';

class TopRatedMovies extends StatelessWidget {
  final String imagePre = 'https://image.tmdb.org/t/p/w500';
  final List top_rated;
  const TopRatedMovies({super.key, required this.top_rated});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: DesignTF(
              text: 'Top Rated Movies',
              color1: Colors.white,
              size: 20,
            )),
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
                                    name: top_rated[index]['title'],
                                    des: top_rated[index]['overview'],
                                    bannerUrl:
                                        'https://image.tmdb.org/t/p/w500${top_rated[index]['backdrop_path']}',
                                    posterurl:
                                        'https://image.tmdb.org/t/p/w500${top_rated[index]['poster_path']}',
                                    vote: top_rated[index]['vote_average']
                                        .toString(),
                                    launch: top_rated[index]['release_date']
                                        .toString())));
                      }),
                      child: Container(
                        height: 180,
                        child: Column(
                          children: [
                            Container(
                                width: 111,
                                height: 160,
                                child: Stack(children: [
                                  Center(child: CircularProgressIndicator()),
                                  FadeInImage.memoryNetwork(
                                    height: 160,
                                    fadeInDuration: Duration(milliseconds: 400),
                                    placeholder: kTransparentImage,
                                    image:
                                        '${imagePre}${top_rated[index]['poster_path']}',
                                    fit: BoxFit.cover,
                                  )
                                ])
                                // decoration: BoxDecoration(
                                //     image: DecorationImage(
                                //         image: NetworkImage(
                                //             '${imagePre}${top_rated[index]['poster_path']}'))),
                                ),
                            Container(
                              height: 20,
                              child: DesignTF(
                                text: top_rated[index]['title'] != null
                                    ? top_rated[index]['title']
                                    : 'loading..',
                                size: 12,
                                color1: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: top_rated.length,
                )),
            Container()
          ],
        ),
      ),
    );
  }
}
