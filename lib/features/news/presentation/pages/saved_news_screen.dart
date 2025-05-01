import 'package:flutter/material.dart';
import 'package:news_app/features/news/presentation/providers/saved_news_screen_provider.dart';
import 'package:news_app/features/news/presentation/widgets/news_tile_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SavedNewsScreen extends StatelessWidget {
  const SavedNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SavedNewsScreenProvider>(
        context,
        listen: false,
      );
      provider.fetch();
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Saved News",
              style: TextStyle(
                fontSize: 25,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
          Expanded(
            child: Consumer<SavedNewsScreenProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (provider.isError) {
                  return Center(child: Text(provider.error));
                } else if (provider.savedNews!.isEmpty ||
                    provider.savedNews == null) {
                  return Center(
                    child: Text(
                      "No Saved News Avilable",
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: provider.savedNews!.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(provider.savedNews![index].id.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          provider.delete(provider.savedNews![index].id!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('News deleted')),
                          );
                        },
                        child: NewsTileWidget(
                          newsEntity: provider.savedNews![index],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
