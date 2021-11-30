import 'package:flutter/material.dart';
import '../data/http_helper.dart';
import '../models/book.dart';

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}
class _BookListScreenState extends State<BookListScreen> {
  List<Book> books = [];
  late bool isLargeScreen;
  late HttpHelper helper;
  List<Color> bgColors = [];

  @override
  void initState() {
    int i;
    helper = HttpHelper();
    helper.getBooks('flutter').then((List<Book> value) {
      for (i = 0; i < value.length; i++) {
        bgColors.add(Colors.white);
      }
      setState(() {
        books = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      isLargeScreen = true;
    } else {
      isLargeScreen = false;
    }
    return Scaffold(
        appBar: AppBar(title: Text('Flutter Books')),
        body: GridView.count(
            childAspectRatio: isLargeScreen ? 8 : 5,
            crossAxisCount: isLargeScreen ? 2 : 1,
            children: List.generate(books.length, (index) {
              return ListTile(
                title: Text(books[index].title),
                subtitle: Text(books[index].authors),
                leading: CircleAvatar(
                  backgroundImage: (books[index].thumbnail) == '' ? null: NetworkImage(books[index].thumbnail),
                ),
              );
            })
        )
    );
  }

}