import 'package:flutter/material.dart';
import 'package:news_app/core/uttils/constants.dart';
import 'package:news_app/features/news/presentation/providers/home_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TabWidget extends StatelessWidget {
  TabWidget({super.key});

  final Map<String, String> newsCatagory = {
    "General": "general",
    "Business": "business",
    "Entertainment": "entertainment",
    "Health": "health",
    "Science": "science",
    "Sports": "sports",
    "Technology": "technology",
  };

  final List<String> catagory = [
    "General",
    "Business",
    "Entertainment",
    "Health",
    "Science",
    "Sports",
    "Technology",
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
      builder: (context, provider, child) {
        final textTheme = Theme.of(context).textTheme;
        return ListView.builder(
          scrollDirection: Axis.horizontal,

          itemCount: catagory.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                provider.onTabChanged(index, newsCatagory[catagory[index]]!);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                padding: EdgeInsets.symmetric(vertical: 1.w),
                decoration: BoxDecoration(
                  border:
                      provider.selectedTab == index
                          ? Border(
                            bottom: BorderSide(color: primaryColor, width: 3),
                          )
                          : null,
                ),
                child: Center(
                  child: Text(
                    catagory[index],
                    style: TextStyle(
                      fontSize: 18.sp,
                      color:
                          provider.selectedTab == index
                              ? textTheme.bodyLarge?.color
                              : textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
