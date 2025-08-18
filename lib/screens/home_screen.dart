import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import '../../widgets/loading_widget.dart';
import '../providers/posts_provider.dart'; // your postsProvider file
import '../widgets/post_card.dart';
import '../widgets/components/post_list.dart';
import '../widgets/components/create_post_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _isRefreshing = false;
  double _previousScrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final currentOffset = _scrollController.position.pixels;

// Check if user is scrolling DOWN (pulling list down, offset decreasing)
final isScrollingDown = currentOffset < _previousScrollOffset;

// print('Scroll position: $currentOffset, isScrollingDown: $isScrollingDown');

if (isScrollingDown &&
    currentOffset <= 50 &&  // close to top
    !_isRefreshing) {
  _handleRefresh();
}

    _previousScrollOffset = currentOffset;
  }

 
  Future<void> _handleRefresh() async {
  setState(() => _isRefreshing = true);

  // Give Flutter a moment to rebuild and show the loading widget
  await Future.delayed(const Duration(milliseconds: 100));

  // Invalidate and wait for new data
  ref.invalidate(postsProvider);
  try {
    await ref.read(postsProvider.future); // Waits until posts are fetched
  } catch (e) {
    debugPrint('Error refreshing posts: $e');
  }

  if (mounted) {
    setState(() => _isRefreshing = false);
  }
}



  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
   leading: Padding(
    padding: const EdgeInsets.all(12.0), // optional padding around the avatar
    child: CircleAvatar(
      backgroundImage: AssetImage('assets/images/Douglas.jpeg'), // your asset path here
      radius: 24, // adjust size as needed
    ),
  ),
  title: const Text('Home Screen'),
  // actions can remain or be removed as needed
),

      body: Column(
        children: [
          if (_isRefreshing)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: LoadingWidget(message: 'Fetching posts...'),
            ),
          Expanded(
            child: PostsListScreen(scrollController: _scrollController),
          ),
        ],
      ),
  
  floatingActionButton: FloatingActionButton(
  onPressed: () {
 showModalBottomSheet(
  context: context,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  ),
  isScrollControlled: true, // lets sheet expand with keyboard
  builder: (BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: CreatePostForm(), // Make sure this is a scrollable/form widget
      ),
    );
  },
);

},

  backgroundColor: Colors.blue,
  child: const Icon(
    Icons.add,
    color: Colors.white,
  ),
),
    );
  }
}


