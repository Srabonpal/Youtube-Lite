import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const YouTubeLiteApp());
}

class YouTubeLiteApp extends StatelessWidget {
  const YouTubeLiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Lite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF0033),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class Video {
  final String title;
  final String channel;
  final String views;
  final String age;
  final String duration;
  final String videoId;
  final String thumbnail;

  const Video({
    required this.title,
    required this.channel,
    required this.views,
    required this.age,
    required this.duration,
    required this.videoId,
    required this.thumbnail,
  });
}

const List<Video> videos = [
  Video(
    title: 'Flutter Tutorial for Beginners - Build Your First App',
    channel: 'Flutter Academy',
    views: '125K views',
    age: '2 days ago',
    duration: '18:42',
    videoId: '1ukSR1GRtMU',
    thumbnail: 'https://i.ytimg.com/vi/1ukSR1GRtMU/hqdefault.jpg',
  ),
  Video(
    title: 'Beautiful Places in Bangladesh | Travel Documentary',
    channel: 'Travel Stories',
    views: '89K views',
    age: '1 week ago',
    duration: '12:30',
    videoId: 'ScMzIvxBSi4',
    thumbnail: 'https://i.ytimg.com/vi/ScMzIvxBSi4/hqdefault.jpg',
  ),
  Video(
    title: 'Python for Data Science - Complete Beginner Guide',
    channel: 'Code With Me',
    views: '340K views',
    age: '3 weeks ago',
    duration: '24:15',
    videoId: 'rfscVS0vtbw',
    thumbnail: 'https://i.ytimg.com/vi/rfscVS0vtbw/hqdefault.jpg',
  ),
  Video(
    title: 'Relaxing Music for Study, Focus and Deep Work',
    channel: 'Calm Music',
    views: '2.1M views',
    age: '1 month ago',
    duration: '1:02:10',
    videoId: 'jfKfPfyJRdk',
    thumbnail: 'https://i.ytimg.com/vi/jfKfPfyJRdk/hqdefault.jpg',
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategory = 0;
  int selectedNav = 0;

  final List<String> categories = [
    'All', 'Music', 'Gaming', 'Flutter', 'Live', 'Travel', 'Learning'
  ];

  void openVideo(Video video) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WebViewScreen(
          title: video.title,
          url: 'https://m.youtube.com/watch?v=${video.videoId}',
        ),
      ),
    );
  }

  void openSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SearchScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              width: 30,
              height: 21,
              decoration: BoxDecoration(
                color: const Color(0xFFFF0033),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.play_arrow, color: Colors.white, size: 19),
            ),
            const SizedBox(width: 7),
            const Text(
              'YouTube',
              style: TextStyle(
                color: Colors.black,
                fontSize: 21,
                fontWeight: FontWeight.w800,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(width: 4),
            const Text('Lite', style: TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Search',
            onPressed: openSearch,
            icon: const Icon(Icons.search, color: Colors.black, size: 27),
          ),
          IconButton(
            tooltip: 'Notifications',
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No new notifications')),
            ),
            icon: const Icon(Icons.notifications_none, color: Colors.black, size: 25),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 4, right: 14),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF673AB7),
              child: Text('S', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 49,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final isSelected = selectedCategory == index;
                return ChoiceChip(
                  label: Text(categories[index]),
                  selected: isSelected,
                  onSelected: (_) => setState(() => selectedCategory = index),
                  backgroundColor: const Color(0xFFF2F2F2),
                  selectedColor: Colors.black,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  showCheckmark: false,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                );
              },
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 12),
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return VideoCard(video: video, onTap: () => openVideo(video));
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        height: 62,
        selectedIndex: selectedNav,
        onDestinationSelected: (index) {
          setState(() => selectedNav = index);
          if (index != 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${['Home', 'Shorts', 'Subscriptions', 'You'][index]} is a demo section')),
            );
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.video_collection_outlined), label: 'Shorts'),
          NavigationDestination(icon: Icon(Icons.subscriptions_outlined), label: 'Subscriptions'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'You'),
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final Video video;
  final VoidCallback onTap;

  const VideoCard({super.key, required this.video, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  video.thumbnail,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.black12,
                    child: const Icon(Icons.play_circle_outline, size: 54, color: Colors.black45),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(4)),
                  child: Text(video.duration, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 10, 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.primaries[video.channel.length % Colors.primaries.length].shade200,
                  child: Text(video.channel[0], style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(video.title, maxLines: 2, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, height: 1.25)),
                      const SizedBox(height: 5),
                      Text('${video.channel} • ${video.views} • ${video.age}',
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black54, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert, size: 21, color: Colors.black87),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  void search() {
    final query = searchController.text.trim();
    if (query.isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WebViewScreen(
          title: 'Search',
          url: 'https://m.youtube.com/results?search_query=${Uri.encodeQueryComponent(query)}',
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back)),
        title: const Text('Search YouTube', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              autofocus: true,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => search(),
              decoration: InputDecoration(
                hintText: 'Search videos',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(onPressed: () => searchController.clear(), icon: const Icon(Icons.close)),
                filled: true,
                fillColor: const Color(0xFFF3F3F3),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: search,
                icon: const Icon(Icons.search),
                label: const Text('Search'),
                style: FilledButton.styleFrom(backgroundColor: const Color(0xFFFF0033)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const WebViewScreen({super.key, required this.title, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;
  int progress = 0;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (value) => setState(() => progress = value),
          onPageStarted: (_) => setState(() { hasError = false; progress = 0; }),
          onPageFinished: (_) => setState(() => progress = 100),
          onWebResourceError: (error) {
            if (error.isForMainFrame == true) setState(() => hasError = true);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        actions: [
          IconButton(onPressed: () => controller.reload(), icon: const Icon(Icons.refresh)),
          IconButton(onPressed: () => controller.goBack(), icon: const Icon(Icons.arrow_back_ios_new, size: 19)),
        ],
        bottom: progress < 100
            ? PreferredSize(
                preferredSize: const Size.fromHeight(3),
                child: LinearProgressIndicator(value: progress == 0 ? null : progress / 100,
                  minHeight: 3, color: const Color(0xFFFF0033), backgroundColor: Colors.white),
              )
            : null,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (hasError)
            Center(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off, size: 48, color: Colors.grey),
                    const SizedBox(height: 12),
                    const Text('Unable to load this page. Check your internet connection.'),
                    const SizedBox(height: 12),
                    FilledButton(onPressed: () => controller.reload(), child: const Text('Try again')),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
