import 'package:flutter/material.dart';

class WhatsAppChat extends StatelessWidget {
  const WhatsAppChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WhatsApp Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                final isMe = index % 2 == 0;
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.green[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('Message $index'),
                  ),
                );
              },
            ),
          ),
          const Divider(thickness: 2),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text('ListView.separated demo', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 150,
            child: ListView.separated(
              itemCount: 20,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) => ListTile(title: Text('Separated item $index')),
            ),
          ),
        ],
      ),
    );
  }
}