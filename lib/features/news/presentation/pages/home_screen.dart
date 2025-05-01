import 'package:flutter/material.dart';
import 'package:news_app/core/uttils/constants.dart';
import 'package:news_app/features/news/presentation/providers/home_screen_provider.dart';
import 'package:news_app/features/news/presentation/widgets/news_tile_widget.dart';
import 'package:news_app/features/news/presentation/widgets/tab_widget.dart';
import 'package:news_app/features/news/presentation/widgets/top_headline_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // HomeScreenProvider provider = Provider.of<HomeScreenProvider>(
    //   context,
    //   listen: false,
    // );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<HomeScreenProvider>(context, listen: false);
      provider.fetchNewsByCategory("General");
      provider.fetchTopHeadlines("General");
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: TabWidget(),
          ), // Fixed TabWidget at the top
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Top Headlines",
                      style: TextStyle(fontSize: 25, color: primaryTextColor),
                    ),
                  ),
                  Consumer<HomeScreenProvider>(
                    builder: (context, provider, _) {
                      return provider.topHeadlines.isEmpty
                          ? Center(child: CircularProgressIndicator())
                          : TopHeadlineWidget();
                    },
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Explore More",
                      style: TextStyle(fontSize: 25, color: primaryTextColor),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Consumer<HomeScreenProvider>(
                    builder: (context, provider, _) {
                      return provider.newsList.isEmpty
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                            physics:
                                NeverScrollableScrollPhysics(), // Disable scrolling for ListView
                            shrinkWrap:
                                true, // Let ListView take only the space it needs
                            itemCount: provider.newsList.length,
                            itemBuilder: (context, index) {
                              return NewsTileWidget(
                                newsEntity: provider.newsList[index],
                              );
                            },
                          );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
