import 'package:flutter/material.dart';

class InstagramPost extends StatelessWidget {
  const InstagramPost({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(child:
         Column(
          children: [
            Container(
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Header
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        CircleAvatar(radius: 18, backgroundImage: NetworkImage('https://picsum.photos/100')),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text('razi_ibrahim', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Icon(Icons.more_vert),
                      ],
                    ),
                  ),

                  // 2. Post image
                  Image.network('https://picsum.photos/400/400', width: double.infinity, fit: BoxFit.cover),

                  // 3. Action icons
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(Icons.favorite_border),
                        SizedBox(width: 12),
                        Icon(Icons.chat_bubble_outline),
                        SizedBox(width: 12),
                        Icon(Icons.send_outlined),
                        Spacer(), // pushes next icon to far right
                        Icon(Icons.bookmark_border),
                      ],
                    ),
                  ),

                  // 4. Likes
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('1,234 likes', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),

                  // 5. Caption
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(text: 'razi_ibrahim ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: 'Learning Flutter layouts today 🚀'),
                        ],
                      ),
                    ),
                  ),

                  // 6. Timestamp
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('2 HOURS AGO', style: TextStyle(color: Colors.grey, fontSize: 11)),
                  ),
                ],
              ),
            ),
          ],
        ),),
      ),
    );
  }
}
