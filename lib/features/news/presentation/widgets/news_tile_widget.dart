import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/uttils/helper.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:sizer/sizer.dart';

class NewsTileWidget extends StatelessWidget {
  final NewsEntity newsEntity;
  const NewsTileWidget({super.key, required this.newsEntity});

  @override
  Widget build(BuildContext context) {
    // if (newsEntity.id != null) print("hi${newsEntity.imageUrl}");
    return InkWell(
      onTap: () {
        context.pushNamed("detail", extra: newsEntity);
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          child: Container(
            height: 18.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              // color: Colors.amber,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 18.h,
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    child:
                        newsEntity.imageUrl != ""
                            ? Image.network(
                              newsEntity.imageUrl!,
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

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          newsEntity.title ?? "No title",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Description
                        Expanded(
                          child: Text(
                            newsEntity.description ?? "No description",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Source and Date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              newsEntity.sourceName ?? "Unknown",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              formatDate(newsEntity.date!),
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
