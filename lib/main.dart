import 'package:flutter/material.dart';
import 'package:movie_app/widgets/fullScreen.dart';
import 'package:movie_app/widgets/toprated_movies.dart';
import 'package:movie_app/widgets/treanding.dart';
import 'package:movie_app/widgets/tv_show.dart';
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
    // print("load movies is call");
  }

  List trending_movies = [];
  List topratedmovies = [];
  List tvlist = [];
  final String api_key = "1fcdf444872f8ffb1777e0e6438f8c4b";
  final String accessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZmNkZjQ0NDg3MmY4ZmZiMTc3N2UwZTY0MzhmOGM0YiIsInN1YiI6IjYzNzRkYzgyNTdkMzc4MDA3YzY3ZWU4NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.SdBjKf0n_KVkv7Q6dV7SfykuPJx9pm7ZmaovVgnHIic";

  loadMovies() async {
    TMDB tmdb_with_custom_log = TMDB(ApiKeys(api_key, accessToken),
        logConfig: ConfigLogger(showErrorLogs: true, showLogs: true));

    Map treanding_result = await tmdb_with_custom_log.v3.trending.getTrending();
    Map topratedresult = await tmdb_with_custom_log.v3.movies.getTopRated();
    Map tvshow = await tmdb_with_custom_log.v3.tv.getPopular();
    // print(treanding_result);
    setState(() {
      trending_movies = treanding_result["results"];
      topratedmovies = topratedresult['results'];
      tvlist = tvshow['results'];
      // print(trending_movies);
    });
    // print(treanding_result);s
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController search_controlar = new TextEditingController();
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   title: DesignTF(text: "Movies", color1: Colors.white, size: 15),
        // ),
        body: ListView(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
          decoration: BoxDecoration(
              color: Color.fromARGB(80, 226, 223, 223),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              GestureDetector(
                onTap: (() {
                  // Login writtern here
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
                      hintText: 'Serach', border: InputBorder.none),
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
      ],
    ));
  }
}
