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
    _nextId = widget.numberList.isEmpty
        ? 1
        : widget.numberList.last.keys.first + 1; // ID 자동 증가
  }

  void addNumber() {
    if (nameController.text.isEmpty ||
        numberController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('모든 필드를 입력해주세요.')),
      );
      return;
    }

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

    Navigator.pop(context, widget.numberList); // 업데이트된 리스트 반환
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('전화번호 추가'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, null),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: '이름'),
            ),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(labelText: '전화번호'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: '설명'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addNumber,
              child: const Text('추가'),
            ),
          ],
        ),
      ),
    );
  }
}