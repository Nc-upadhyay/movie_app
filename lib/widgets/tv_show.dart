import 'package:flutter/material.dart';

import '../utils/fontDesign.dart';
import 'fullScreen.dart';

class TopTVShow extends StatelessWidget {
  final String imagePre = 'https://image.tmdb.org/t/p/w500';
  final List tv_list;

  const TopTVShow({super.key, required this.tv_list});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.all(8),
                child: DesignTF(
                  text: 'Top Tv Show',
                  color1: Colors.white,
                  size: 20,
                )),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (() {
                        print(tv_list);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreen(
                                    name: tv_list[index]['name'],
                                    des: tv_list[index]['overview'],
                                    bannerUrl:
                                        'https://image.tmdb.org/t/p/w500${tv_list[index]['backdrop_path']}',
                                    posterurl:
                                        'https://image.tmdb.org/t/p/w500${tv_list[index]['poster_path']}',
                                    vote: tv_list[index]['vote_average']
                                        .toString(),
                                    launch: tv_list[index]['first_air_date']
                                        .toString())));
                      }),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Container(
                              width: 310,
                              height: 210,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          '${imagePre}${tv_list[index]['backdrop_path']}'),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              child: DesignTF(
                                text: tv_list[index]['original_name'] != null
                                    ? tv_list[index]['original_name']
                                    : 'loading..',
                                size: 14,
                                color1: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: tv_list.length,
                )),
            Container()
          ],
        ),
      ),
    );
  }
}
