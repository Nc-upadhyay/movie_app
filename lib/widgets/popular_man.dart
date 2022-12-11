import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:transparent_image/transparent_image.dart';
import '../utils/fontDesign.dart';
import 'AboutMan.dart';

class PopularMan extends StatelessWidget {
  final List manlist;
  const PopularMan({super.key, required this.manlist});
  final String imagePre = 'https://image.tmdb.org/t/p/w500';
  @override
  Widget build(BuildContext context) {
    print("================= popular man==========");
    print(manlist);
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(3),
              child: DesignTF(
                text: "Popular Person",
                color1: Colors.white,
                size: 20,
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      List detail = manlist[index]['known_for'];
                      print("detail=============== $detail");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutMan(
                                    detail: detail,
                                    name: manlist[index]['name'],
                                    popularity:
                                        manlist[index]['popularity'].toString(),
                                    profile_path:
                                        "$imagePre${manlist[index]['profile_path']}",
                                    work: manlist[index]
                                        ['known_for_department'],
                                  )));
                    },
                    child: Container(
                      height: 200,
                      child: Column(
                        children: [
                          Container(
                            height: 170,
                            margin: EdgeInsets.fromLTRB(5, 5, 2, 0),
                            child: ClipOval(
                              child: Image.network(
                                  "$imagePre${manlist[index]['profile_path']}",
                                  width: 150,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: DesignTF(
                              text: manlist[index]['name'] != null
                                  ? manlist[index]['name']
                                  : 'loading..',
                              color1: Colors.white,
                              size: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: manlist.length,
              ),
            )
          ],
        ));
  }
}
