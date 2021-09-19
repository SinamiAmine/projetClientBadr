import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projetbadr/models/Book.dart';
import 'package:projetbadr/services/book_service.dart';
import 'package:rating_bar/rating_bar.dart';

class MovieDetail extends StatefulWidget {
  // Movie object to handle.
  final String id;

  // Constructor for the class.
  MovieDetail(this.id);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  Book? _book;
  bool? _isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.id);
    BookService.getBook(widget.id).then((response) {
      setState(() {
        _isLoading = false;
      });

      if (response.error!) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      _book = response.data;
    });
    print(_book);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Detail Book"),
        ),
        body: new ListView(children: <Widget>[
          new Image.network(_book!.image!),
          SizedBox(
            height: 0,
          ),
          new Container(
            padding: const EdgeInsets.all(20.0),
            child: new Row(
              children: [
                // First child in the Row for the name and the
                // Release date information.
                new Expanded(
                  // Name and Release date are in the same column
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Code to create the view for name.
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topRight,
                          child: new RaisedButton(
                            onPressed: () {},
                            color: Colors.lightBlueAccent,
                            child: Text('Add to favoris'),
                          ),
                        ),
                      ),
                      new Container(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: new Text(
                          "Title: " + _book!.title!,
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Code to create the view for release date.
                      new Text(
                        "Description : " + _book!.desc!,
                        style: new TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                // Icon to indicate the rating.
                // new Text('${widget.book.isbn13}'),
              ],
            ),
          ),
          RatingBar.readOnly(
            initialRating: 3.5,
            isHalfAllowed: true,
            halfFilledIcon: Icons.star_half,
            filledIcon: Icons.star,
            emptyIcon: Icons.star_border,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              new Container(
                  padding: const EdgeInsets.all(32.0),
                  child: new Text(
                    _book!.price!,
                    softWrap: true,
                  )),
              Container(
                  padding: const EdgeInsets.all(32.0),
                  child: new Text(
                    _book!.pages! + " Pages",
                    softWrap: true,
                  )),
              Container(
                  padding: const EdgeInsets.all(32.0),
                  child: new Text(
                    "Year : " + _book!.year!,
                    softWrap: true,
                  )),
            ],
          )
        ]));
  }
}
