import 'package:flutter/material.dart';
import 'package:newsapp/article_model.dart';

import 'news.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ArticleModel> articles = [];

  bool _loading = true;

  @override
  void initState() {
    getNews();
    super.initState();
  }

  getNews() async {
    NewsClass newsClass = NewsClass();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        centerTitle: true,
      ),
      body: _loading == true
          ? const Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return BlogTile(
                      imageurl: articles[index].imageurl!,
                      name:
                          "${articles[index].firstname} ${articles[index].middlename} ${articles[index].lastname} ",
                      desc: articles[index].sayings![0],
                  );
                },
                itemCount: articles.length,
              ),
            ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageurl, name,desc;

  BlogTile({required this.imageurl, required this.name,required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                Image.network(imageurl,fit: BoxFit.contain,),
                const SizedBox(height: 7,),
                Text(name,style: const TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text(desc,style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
