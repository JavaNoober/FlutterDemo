import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


///通过构造函数传递值跳转
class SavedWidget extends StatefulWidget {
  final Set<WordPair> selfWordList; //当前存储的字典

  SavedWidget({this.selfWordList});

  @override
  State<StatefulWidget> createState() => new SavedWidgetState();
}

class SavedWidgetState extends State<SavedWidget> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: const Text("存储的字典222")),
        body: wordsListView());
  }

  Widget wordsListView() {
//    var list = selfWordList.map((WordPair word){
//      return listItem(word);
//    });
//    return new ListView(children: list.toList());
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.selfWordList.length * 2,
        itemBuilder: (BuildContext context, int index) {
          if (index.isOdd) {
            return new Divider();
          }
          int i = index ~/ 2;
          WordPair word = widget.selfWordList.elementAt(i);
          print(word.asPascalCase);
          return listItem(word);
        });
  }

  Widget listItem(WordPair wordPair) {
    return new ListTile(title: new Text(wordPair.asPascalCase));
  }
}