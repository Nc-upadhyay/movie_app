import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app/widgets/popular_man.dart';
import 'package:movie_app/widgets/searchpage.dart';
import 'package:movie_app/widgets/toprated_movies.dart';
import 'package:movie_app/widgets/treanding.dart';
import 'package:movie_app/widgets/tv_show.dart';
import 'package:http/http.dart';

import 'package:tmdb_api/tmdb_api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    super.initState();
    loadMovies();
  }

  List search_list = [];
  List trending_movies = [];
  List topratedmovies = [];
  List tvlist = [];
  List popular_man = [];
  final String api_key = "1fcdf444872f8ffb1777e0e6438f8c4b";
  final String accessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZmNkZjQ0NDg3MmY4ZmZiMTc3N2UwZTY0MzhmOGM0YiIsInN1YiI6IjYzNzRkYzgyNTdkMzc4MDA3YzY3ZWU4NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.SdBjKf0n_KVkv7Q6dV7SfykuPJx9pm7ZmaovVgnHIic";

  void loadSearchList(String text) async {
    Response response = await get(Uri.parse(
        "https://api.themoviedb.org/3/search/multi?api_key=$api_key&query=$text"));
    Map data = jsonDecode(response.body);
    search_list = data['results'];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => SerachPage(
                  search_list: search_list,
                ))));
  }

  loadMovies() async {
    TMDB tmdb_with_custom_log = TMDB(ApiKeys(api_key, accessToken),
        logConfig: ConfigLogger(showErrorLogs: true, showLogs: true));

    Map treanding_result = await tmdb_with_custom_log.v3.trending.getTrending();
    Map topratedresult = await tmdb_with_custom_log.v3.movies.getTopRated();
    Map tvshow = await tmdb_with_custom_log.v3.tv.getPopular();
    Response response = await get(Uri.parse(
        "https://api.themoviedb.org/3/person/popular?api_key=$api_key&language=en-US&page=1"));
    Map popularman = jsonDecode(response.body);

    setState(() {
      popular_man = popularman['results'];
      print("popla ================== $popular_man");

      trending_movies = treanding_result["results"];
      topratedmovies = topratedresult['results'];
      tvlist = tvshow['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController search_controlar = new TextEditingController();
    return Scaffold(
        body: ListView(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
              color: Color.fromARGB(80, 226, 223, 223),
              borderRadius: BorderRadius.circular(35)),
          child: Row(
            children: [
              GestureDetector(
                onTap: (() {
                  // Logic writtern here
                  loadSearchList(search_controlar.text.toString().trim());
                  search_controlar.text.toString().trim() != null
                      ? loadSearchList(search_controlar.text.toString().trim())
                      : showDialogBox(context, "Please Enter Valid Name...");
                }),
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 1, 8, 1),
                  child: Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.blue,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: search_controlar,
                  decoration: InputDecoration(
                      hintText: 'Serach Tv shows, Movies',
                      border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
        TopTVShow(
          tv_list: tvlist,
        ),
        TopRatedMovies(top_rated: topratedmovies),
        TrendingMovies(
          treanding: trending_movies,
        ),
        PopularMan(
          manlist: popular_man,
        ),
      ],
    ));
  }

  Widget showDialogBox(BuildContext context, String msg) {
    return AlertDialog(
      title: Text('Warning !'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [Text(msg)],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Ok"))
      ],
    );
  }
}
