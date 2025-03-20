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


  void _addTodo() {
    if (key.currentState!.validate() && selectedDate != null) {
      setState(() {
        _todos.add({
          'title': _controller.text,
          'deadline': selectedDate!,
          'done': false,
        });
        _controller.clear();
        selectedDate = null;
        _dateError = null;
      });
    }
  }

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
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(3000),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                          _dateError = null;
                        });
                      }
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    selectedDate == null
                        ? 'Select a date'
                        : '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: _dateError != null ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              ),
              if (_dateError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: Text(
                    _dateError!,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              Form(
                key: key,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          labelText: 'Kegiatan',
                          hintText: 'Masukkan kegiatan',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kegiatan tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          if (selectedDate == null) {
                            _dateError = 'Tanggal harus dipilih';
                          }
                        });

                        if (key.currentState!.validate() &&
                            selectedDate != null) {
                          _addTodo();
                        }
                      },
                      child: const Text('Tambah'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _todos.length,
                  itemBuilder: (context, index) {
                    final todo = _todos[index];
                    final isDone = todo['done'];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  todo['title'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Deadline: ${todo['deadline'].day}-${todo['deadline'].month}-${todo['deadline'].year}',
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
