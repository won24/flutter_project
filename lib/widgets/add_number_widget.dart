import 'package:flutter/material.dart';

class AddNumber extends StatefulWidget {
  final List<Map<int, String>> numberList;

  const AddNumber({Key? key, required this.numberList}) : super(key: key);

  @override
  State<AddNumber> createState() => _NumberAddState();
}

class _NumberAddState extends State<AddNumber> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late int _nextId;

  @override
  void initState() {
    super.initState();
    _nextId = widget.numberList.isEmpty ? 1 : widget.numberList.last.keys.first + 1;
  }

  void addNumber() {
    setState(() {
      widget.numberList.add({
        _nextId: '${nameController.text}, ${numberController.text}, ${descriptionController.text}'
      });
      _nextId++;

      // 입력 필드 초기화
      nameController.clear();
      numberController.clear();
      descriptionController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('전화번호 추가'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, widget.numberList),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: '이름'),
            ),
            TextField(
              controller: numberController,
              decoration: InputDecoration(labelText: '전화번호'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: '설명'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addNumber();
                Navigator.pop(context, widget.numberList);
              },
              child: Text('추가'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}