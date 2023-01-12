import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_app/utils/fontDesign.dart';

class FullScreen extends StatelessWidget {
  final String name, des, bannerUrl, posterurl, vote, launch;
  const FullScreen(
      {super.key,
      required this.name,
      required this.des,
      required this.bannerUrl,
      required this.posterurl,
      required this.vote,
      required this.launch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                      child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      bannerUrl,
                      fit: BoxFit.cover,
                    ),
                  )),
                  Positioned(
                      top: 200,
                      child: DesignTF(
                        text: '  Average Rating-  ' + vote,
                        color1: Colors.white,
                        size: 14,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: DesignTF(
                text: name != null ? name : 'Loading..',
                color1: Colors.white,
                size: 25,
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 10),
                child: DesignTF(
                  text: 'Releasing on -  ${launch != null ? launch : "..."}',
                  color1: Colors.white,
                  size: 15,
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  height: 200,
                  width: 100,
                  child: Image.network(posterurl),
                ),
                Flexible(
                  child: Container(
                    child: DesignTF(
                      text: des != null ? des : 'Description not available',
                      color1: Colors.white,
                      size: 15,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
