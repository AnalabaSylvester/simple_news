import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<Article>> future;

  String? searching;
   


  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  List<String> categoryItem = [
    "GENERAL",
    "BUSINESS",
    "ENTERTAINMENT",
    "HEALTH",
    "SCIENCE",
    "SPORTS",
    "TEXHNOLOGY"
  ];

  late String selectCategory;

  @override
  void initState() {
    selectCategory = categoryItem[6];
    future = getNewsData();
    super.initState();
  }

  Future<List<Article>> getNewsData() async {
    NewsAPI newsAPI = NewsAPI("269acef232e44d728a1829539da023fb");
    return await newsAPI.getTopHeadlines(
      country: 'us',
      query: searching,
      category: selectCategory,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearching ? searchAppBar() : appBar(),
      body: Column(
        children: [
          _buildCategories(),
          Expanded(
            child: FutureBuilder(
              initialData: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Oops something went wrong!!.."),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.orange),
                                shape: MaterialStateProperty.all(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))))),
                            onPressed: () {},
                            child: const Text(
                              "Try again",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            )),
                      ),
                    ],
                  ),
                )
              ],
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return _buildNewsList(snapshot.data as List<Article>);
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.signal_wifi_connected_no_internet_4_outlined,
                            size: 85,
                            color: Colors.red,
                          ),
                          const Text("No News abailable",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                              "Check your network settings, or reload the app..",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 50,
                              width: 150,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                              ),
                              child: const Center(
                                child: Text(
                                  "Try again",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }
              },
              future: future,
            ),
          )
        ],
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                isSearching = true;
              });
            },
            icon: const Icon(Icons.search))
      ],
      backgroundColor: Colors.red,
      title: const Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "News App",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            ]),
      ),
      elevation: 10,
    );
  }

  Widget _buildNewsList(List<Article> articleList) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Article article = articleList[index];
        return _buildNewsItem(article);
      },
      itemCount: articleList.length,
    );
  }

  Widget _buildNewsItem(Article article) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Image.network(
              article.urlToImage ?? "",
              fit: BoxFit.fitHeight,
              errorBuilder: ((context, error, stackTrace) {
                return const Icon(Icons.image_not_supported);
              }),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title!,
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  article.source.name!,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  searchAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            isSearching = false;
            searching = null;
            searchController.text = "";
            future = getNewsData();
          });
        },
      ),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                searching = searchController.text;
                future = getNewsData();
              });
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 25,
            ))
      ],
      backgroundColor: Colors.red,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          
          decoration: const InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.white70),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
          ),
          controller: searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
        ),
      ),
      elevation: 10,
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
          itemCount: categoryItem.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectCategory = categoryItem[index];
                    future = getNewsData();
                  });
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                  categoryItem[index] == selectCategory
                      ? Colors.red.withOpacity(0.5)
                      : Colors.redAccent,
                )),
                child: Text(categoryItem[index]),
              ),
            );
          })),
    );
  }
}

// 269acef232e44d728a1829539da023fb
