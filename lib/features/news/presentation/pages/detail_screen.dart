import 'package:flutter/material.dart';
import 'package:news_app/features/news/domain/entities/news_entity.dart';
import 'package:news_app/features/news/presentation/providers/detail_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailScreen extends StatefulWidget {
  final NewsEntity news;
  const DetailScreen({super.key, required this.news});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()..loadRequest(Uri.parse(widget.news.url!));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DetailScreenProvider>(
        context,
        listen: false,
      );
      provider.checkIfNewsSaved(widget.news);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "News",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Consumer<DetailScreenProvider>(
            builder: (context, provider, _) {
              return IconButton(
                icon: Icon(
                  provider.isSaved ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.white,
                  size: 4.h,
                ),
                onPressed: () => provider.toggleSaveNews(widget.news),
              );
            },
          ),
        ],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
