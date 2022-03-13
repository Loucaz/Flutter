import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/MyHomePage.dart';

class Film extends StatefulWidget {
  final FilmJSON filmJSON;
  Film(this.filmJSON, {Key? key}) : super(key: key);
  bool fav = false;

  @override
  _FilmState createState() => _FilmState();
}

class _FilmState extends State<Film> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Column(children: <Widget>[
              widget.filmJSON.image != null
                  ? Image.network(
                      "https://image.tmdb.org/t/p/w500" +
                          (widget.filmJSON.image ?? "description"),
                      width: 120,
                      height: 150,
                    )
                  : Container(
                      width: 120,
                      height: 150,
                    )
            ]),
            Flexible(
              fit: FlexFit.loose,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.filmJSON.title ?? "description",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Text(widget.filmJSON.date ?? "description",
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic)),
                          ]),
                    ),
                    IconButton(
                      icon: widget.fav == true
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                      color: Colors.pink,
                      tooltip: 'Like',
                      onPressed: () {
                        setState(() {
                          widget.fav = !widget.fav;
                        });
                      },
                    ),
                  ]),
                  const Divider(),
                  Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          widget.filmJSON.description ?? "Pas de description",
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
