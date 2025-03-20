import 'package:flutter/material.dart';

class Todopage extends StatefulWidget {
  const Todopage({super.key});

  @override
  State<Todopage> createState() => _TodopageState();
}

class _TodopageState extends State<Todopage> {
  final TextEditingController _controller = TextEditingController();
  final key = GlobalKey<FormState>();
  List<Map<String, dynamic>> _todos = [];
  DateTime? selectedDate;
  String? _dateError;

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Page'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Task Date:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
