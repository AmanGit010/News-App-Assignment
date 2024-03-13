// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/core/models/news_model.dart';
import 'package:news_app/feature/main/view/news_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';
import 'store/main_store.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final store = context.read<MainStore>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBlack,
        title: Text(
          'News App',
          style: AppTextStyle.gt18white
              .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              print(store.isGridView);
              store.toggleGridView();
              print(store.isGridView);
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset(
                'assets/svg/grid.svg',
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Observer(builder: (_) {
            return LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 1100) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            // width: 300,
                            width: MediaQuery.sizeOf(context).width * 0.5,
                            child: _Listview(),
                          ),
                          SizedBox(
                            // width: 300,
                            width: MediaQuery.sizeOf(context).width * 0.5,
                            child: _Listview(),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  print(store.isGridView);
                  return store.isGridView ? _Gridview() : _Listview();
                }
              },
            );
          }),
        ),
      ),
    );
    //
  }
}

class _Gridview extends StatelessWidget {
  const _Gridview();

  @override
  Widget build(BuildContext context) {
    NewsView newsView = NewsView();
    return FutureBuilder<NewsModel?>(
      future: newsView.fetchNews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _Shimmer();
        } else {
          return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              // itemCount: snapshot.data?.articles!.length,
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return _DescriptionSheet(
                          "${snapshot.data!.articles![index].urlToImage}",
                          "${snapshot.data!.articles![index].title}",
                          "${snapshot.data!.articles![index].description}",
                          "${snapshot.data!.articles![index].content}",
                          "${snapshot.data!.articles![index].author}",
                          "${snapshot.data!.articles![index].publishedAt}",
                          "${snapshot.data!.articles![index].url}",
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(4, 4),
                              blurRadius: 20,
                              color: AppColors.black,
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              height: 50,
                              imageUrl: snapshot
                                  .data!.articles![index].urlToImage
                                  .toString(),
                              placeholder: (context, url) {
                                return SpinKitFadingCircle(
                                  color: AppColors.purple,
                                );
                              },
                              placeholderFadeInDuration:
                                  Duration(milliseconds: 800),
                              errorListener: (value) {
                                return null;
                              },
                              errorWidget: (context, url, error) {
                                return Text("Image not available");
                              },
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${snapshot.data?.articles![index].title}",
                              style: AppTextStyle.gt18blackbold
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
      },
    );
  }
}

class _Listview extends StatelessWidget {
  const _Listview();

  @override
  Widget build(BuildContext context) {
    NewsView newsView = NewsView();
    return FutureBuilder<NewsModel?>(
      future: newsView.fetchNews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _Shimmer();
        } else {
          return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              // itemCount: snapshot.data?.articles!.length,
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return _DescriptionSheet(
                          "${snapshot.data!.articles![index].urlToImage}",
                          "${snapshot.data!.articles![index].title}",
                          "${snapshot.data!.articles![index].description}",
                          "${snapshot.data!.articles![index].content}",
                          "${snapshot.data!.articles![index].author}",
                          "${snapshot.data!.articles![index].publishedAt}",
                          "${snapshot.data!.articles![index].url}",
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(4, 4),
                              blurRadius: 20,
                              color: AppColors.black,
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl: snapshot
                                  .data!.articles![index].urlToImage
                                  .toString(),
                              placeholder: (context, url) {
                                return SpinKitFadingCircle(
                                  color: AppColors.purple,
                                );
                              },
                              placeholderFadeInDuration:
                                  Duration(milliseconds: 800),
                              errorListener: (value) {
                                return null;
                              },
                              errorWidget: (context, url, error) {
                                return Text("Image not available");
                              },
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${snapshot.data?.articles![index].title}",
                              style: AppTextStyle.gt18blackbold,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${snapshot.data?.articles![index].description}",
                              style: AppTextStyle.gt18black,
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              // width: 200,
                              child: Row(
                                children: [
                                  Text(
                                    "${snapshot.data?.articles![index].author}",
                                    style: AppTextStyle.gt18blackbold
                                        .copyWith(fontSize: 12),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "${snapshot.data?.articles![index].publishedAt}",
                                    style: AppTextStyle.gt18black
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
      },
    );
  }
}

class _DescriptionSheet extends StatelessWidget {
  const _DescriptionSheet(this.url, this.title, this.desc, this.content,
      this.author, this.date, this.articleUrl);

  final String url;
  final String title;
  final String desc;
  final String content;
  final String author;
  final String date;
  final String articleUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(url),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style:
                  AppTextStyle.gt18blackbold.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 10),
            Text(
              desc,
              style: AppTextStyle.gt18white,
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: AppTextStyle.gt18white,
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse(articleUrl));
              },
              child: Text(
                "Link to full article",
                style: AppTextStyle.gt18blackbold.copyWith(
                    color: AppColors.purple,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.purple),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              author,
              style: AppTextStyle.gt18blackbold.copyWith(
                color: AppColors.white,
              ),
            ),
            Text(date, style: AppTextStyle.gt18white),
          ],
        ),
      ),
    );
  }
}

class _Shimmer extends StatelessWidget {
  const _Shimmer();

  @override
  Widget build(BuildContext context) {
    final store = context.read<MainStore>();
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.95,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  if (store.isGridView)
                    Row(
                      children: [
                        Container(
                          height: store.isGridView ? 100 : 200,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: store.isGridView ? 100 : 200,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    )
                  else
                    Container(
                      height: store.isGridView ? 100 : 200,
                      // width: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  const SizedBox(height: 15),
                  if (store.isGridView)
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    )
                  else
                    Container(
                      height: 35,
                      // width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        height: 25,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 25,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
