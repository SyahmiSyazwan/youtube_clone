import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark, // Enable dark theme
        primaryColor: Colors.black,
        scaffoldBackgroundColor: const Color.fromRGBO(29, 29, 29, 1), // Set background to black
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 17, 17, 17), // AppBar dark background
          titleTextStyle: TextStyle(color: Colors.white), // AppBar text color
        ),
        iconTheme: IconThemeData(color: Colors.white), // Icon colors
      ),
      home: YouTubeClone(),
    );
  }
}

class YouTubeClone extends StatefulWidget {
  @override
  _YouTubeCloneState createState() => _YouTubeCloneState();
}

class _YouTubeCloneState extends State<YouTubeClone> {
  int _selectedSegmentIndex = 0;
  int _selectedIndex = 0; // Index for the BottomNavigationBar

  final List<String> _segments = ['All', 'Shorts', 'Videos', 'Unwatched', 'Watched'];

  // List of pages or content corresponding to each navigation item
  final List<Widget> _pages = [
    Center(child: Text('Home Page', style: TextStyle(color: Colors.white))),
    Center(child: Text('Shorts Page', style: TextStyle(color: Colors.white))),
    Center(child: Text('Create Page', style: TextStyle(color: Colors.white))),
    Center(child: Text('Subscriptions Page', style: TextStyle(color: Colors.white))),
    Center(child: Text('Profile Page', style: TextStyle(color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'YouTube',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.cast),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Segment Buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_segments.length, (index) {
                return TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedSegmentIndex = index;
                    });
                  },
                  child: Text(
                    _segments[index],
                    style: TextStyle(
                      color: _selectedSegmentIndex == index ? Colors.blue : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
            ),
          ),
          
          // Content based on selected segment
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Number of videos to display
              itemBuilder: (context, index) {
                // Add Shorts section at the start of the list if the "All" or "Shorts" segment is selected
                if (_selectedSegmentIndex == 0 || _selectedSegmentIndex == 1) {
                  if (index == 0) {
                    return Column(
                      children: [
                        // Shorts Header
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Shorts",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.more_vert, color: Colors.white),
                            ],
                          ),
                        ),
                        // Shorts Section (Horizontal Scroll)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(5, (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    width: 120,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          'https://cloudinary-marketing-res.cloudinary.com/image/upload/ar_0.5,c_fill,g_auto,w_433/q_auto/f_auto/graphic_wall_pose.jpg',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
                // Video content section
                return VideoTile(index: index); // Pass index to VideoTile
              },
            ),
          ),
        ],
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.slideshow),
            label: 'Shorts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: 'Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 17, 17, 17), // Bottom bar background color
        unselectedItemColor: Colors.white, // Color for unselected items
        selectedItemColor: Colors.blue, // Color for selected items
      ),
    );
  }
}

class VideoTile extends StatelessWidget {
  final int index;

  VideoTile({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // Video Thumbnail
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://cloudinary-marketing-res.cloudinary.com/image/upload/ar_1.0,c_fill,g_auto/w_867/q_auto/f_auto/hiking_dog_mountain.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          // Video Title
          Row(
            children: [
              Expanded(
                child: Text(
                  'Sample Video Title $index',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // 3-Dot Menu for Options
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  // Show options (for example, Save, Share)
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => ListView(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.save_alt),
                          title: Text('Save'),
                          onTap: () {
                            // Add functionality here
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.share),
                          title: Text('Share'),
                          onTap: () {
                            // Add functionality here
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              // Video Channel Name and Views
              Text(
                'Channel Name • 1.2M views • 1 day ago',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
          SizedBox(height: 10),
          
          // Community Post Section (With Like, Dislike, Share, Comment)
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // Buttons: Like, Dislike, Share, Comment
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up_alt_outlined),
                      onPressed: () {},
                    ),
                    Text('811'),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.thumb_down_alt_outlined),
                      onPressed: () {},
                    ),
                    Text('169'),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {},
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {},
                    ),
                    SizedBox(width: 10),
                    // Comment Text
                    Text('170 comments'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
