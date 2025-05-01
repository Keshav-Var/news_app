import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/presentation/providers/home_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TopHeadlineWidget extends StatelessWidget {
  const TopHeadlineWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenProvider provider = Provider.of<HomeScreenProvider>(
      context,
      listen: false,
    );
    List<NewsEntity> news = provider.topHeadlines;
    // print(news[0].imageUrl);
    return CarouselSlider.builder(
      itemCount: news.length,
      itemBuilder: (BuildContext context, int itemIndex, int i) {
        return InkWell(
          onTap: () => {context.pushNamed("detail", extra: news[itemIndex])},
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: double.infinity,
            child: Stack(
              children: [
                // Background Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 30.h,
                    width: double.infinity,
                    child:
                        news[itemIndex].imageUrl != ""
                            ? Image.network(
                              news[itemIndex].imageUrl!,
                              fit: BoxFit.fill,
                              errorBuilder:
                                  (context, error, stackTrace) => Image.asset(
                                    "assets/images/hero.png", // your image path

                                    fit: BoxFit.fill,
                                  ),
                            )
                            : Image.asset(
                              "assets/images/hero.png", // your image path

                              fit: BoxFit.fill,
                            ),
                  ),
                ),

                // Dark gradient overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 12.h,
                    decoration: BoxDecoration(
                      // color: Colors.amber,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          // ignore: deprecated_member_use
                          Colors.black26.withOpacity(0.2),
                          // ignore: deprecated_member_use
                          Colors.black12.withOpacity(0.4),
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 50,
                  left: 10,
                  right: 10,
                  child: Text(
                    news[itemIndex].title ?? "No title",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 15,
                  left: 10,
                  right: 10,
                  child: Text(
                    news[itemIndex].description ?? "No description",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 25.h,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        enlargeCenterPage: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enableInfiniteScroll: false,
      ),
    );
  }
}
