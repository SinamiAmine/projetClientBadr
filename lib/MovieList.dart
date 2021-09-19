import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projetbadr/MovieDetail.dart';
import 'package:projetbadr/models/Book.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  /// Method to get movies from the backend
  Future<List<Book>?> getMovies() async {
    final String url = 'https://api.itbook.store/1.0/new';
    var httpClient = new HttpClient();
    try {
      // Make the call
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        return createMovieList(json);
      } else {
        print("Failed http call.");
      }
    } catch (exception) {
      print(exception.toString());
    }
    return null;
  }

  /// Method to parse information from the retrieved data
  List<Book>? createMovieList(String resultString) {
    List? results = getResultsList(resultString);

    List<Book>? list = [];
    for (int i = 0; i < results.length; i++) {
      list.add(createMovieObject(results[i]));
    }
    return list;
  }

  /// Method to create a movie object.
  Book createMovieObject(objectItem) {
    String? title = objectItem["title"];
    String subtitle = objectItem["subtitle"];
    String? isbn13 = objectItem["isbn13"];
    String price = objectItem["price"];
    String image = objectItem["image"];
    String url = objectItem["url"];
    String authors = objectItem["authors"];
    String publisher = objectItem["publisher"];
    String language = objectItem["language"];
    String pages = objectItem["pages"];
    String year = objectItem["year"];
    String rating = objectItem["rating"];
    String desc = objectItem["desc"];

    return new Book(
        title: title,
        subTitle: subtitle,
        isbn13: isbn13,
        price: price,
        image: image,
        url: url,
        authors: authors,
        publisher: publisher,
        language: language,
        pages: pages,
        year: year,
        rating: rating,
        desc: desc);
  }

  List getResultsList(String resultString) {
    // Decode the json response
    var data = json.decode(resultString);
    // Get the result list
    return data["books"];
  }

  List<Widget> createMovieCardItem(List<Book>? movies, BuildContext context) {
    // Children list for the list.
    List<Widget>? listElementWidgetList = <Widget>[];
    if (movies != null) {
      var lengthOfList = movies.length;
      for (int i = 0; i < lengthOfList; i++) {
        Book? movie = movies[i];
        // Image URL
        var imageURL = movie.image;
        // List item created with an image of the poster
        var listItem = new GridTile(
            footer: new GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new MovieDetail(movie.isbn13!)));
                },
                child: new GridTileBar(
                  backgroundColor: Colors.black45,
                  title: new Text(movie.title!),
                )),
            child: new GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new MovieDetail(movie.isbn13!)));
              },
              child: Container(
                  color: Colors.grey[600],
                  child: new Image.network(imageURL!, fit: BoxFit.cover)),
            ));
        listElementWidgetList.add(listItem);
      }
    }
    return listElementWidgetList;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: new FutureBuilder(
          future: getMovies(),
          builder: (BuildContext context, AsyncSnapshot<List<Book>?> snapshot) {
            if (!snapshot.hasData)
              // Shows progress indicator until the data is load.
              return new MaterialApp(
                  home: new Scaffold(
                body: new Center(
                  child: new CircularProgressIndicator(),
                ),
              ));
            // Shows the real data with the data retrieved.
            List<Book>? movies = snapshot.data;
            return new CustomScrollView(
              primary: false,
              slivers: <Widget>[
                new SliverPadding(
                  padding: const EdgeInsets.all(10.0),
                  sliver: new SliverGrid.count(
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    crossAxisCount: 2,
                    children: createMovieCardItem(movies, context),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
