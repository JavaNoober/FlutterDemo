import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

//主app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Welcome to Flutter',
        theme: new ThemeData(primaryColor: Colors.white), //主题
        home: new RandomWords());
  }
}

//主界面
class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> wordList = <WordPair>[]; //所有的随机字典

  final Set<WordPair> selfWordList = new Set<WordPair>(); //当前存储的字典

  final TextStyle wordStyle = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
//    WordPair wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);

    return new Scaffold(
      appBar: new AppBar(
        title: const Text("字典"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: pushSave)
        ],
      ),
      body: buildWordListView(),
    );
  }

  //listview 列表
  Widget buildWordListView() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          //是否是奇数
          return new Divider();
        }
        final int index = i ~/ 2;
        print(index); // 1 2 3 4
        print(i / 2); // 1.0 2.0 3.0 4.0
        if (index >= wordList.length) {
          wordList.addAll(generateWordPairs().take(10));
        }

        return buildRow(wordList[index]);
      },
    );
  }

  //listview 中的每一行
  Widget buildRow(WordPair wordPair) {
    final bool alreadySaved = selfWordList.contains(wordPair);

    return new ListTile(
      title: new Text(wordPair.asPascalCase, style: wordStyle),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        //setState 可以出发build方法从而更新ui
        setState(() {
          if (alreadySaved) {
            selfWordList.remove(wordPair);
          } else {
            selfWordList.add(wordPair);
          }
        });
      },
    );
  }

  void pushSave() {
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (context){
          final tiles = selfWordList.map((wordPair){
            return new ListTile(
              title: new Text(wordPair.asPascalCase,style: wordStyle),
            );
          });
          final divid = ListTile.divideTiles(context : context, tiles: tiles)
              .toList();

          return new Scaffold(
              appBar: new AppBar(title: new Text("存储的字典")),
              body: new ListView(children: divid));
        }));
  }
}

class SavedWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new SavedWidgetState();

}

class SavedWidgetState extends State<SavedWidget>{
  final Set<WordPair> selfWordList = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  }

  Widget wordsListView(){
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext context, int index){
          if(index.isOdd){
            return new Divider();
          }

          return listItem(selfWordList.elementAt(index ~/ 2));
        });
  }

  Widget listItem(WordPair wordPair){
    return new ListTile(title: new Text(wordPair.asPascalCase));
  }
}
