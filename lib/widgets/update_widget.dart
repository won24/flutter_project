import 'package:flutter/material.dart';

class UpdateWidget extends StatefulWidget {
  final List<Map<int,String>> numberList;
  final String name;
  final String phoneNumber;
  final String description;
  final VoidCallback onDelete;
  final Function(String, String, String) onUpdate;

  const UpdateWidget({
    super.key,
    required this.numberList,
    required this.name,
    required this.phoneNumber,
    required this.description,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  State<UpdateWidget> createState() => _UpdateWidgetState();
}

class _UpdateWidgetState extends State<UpdateWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _phoneController = TextEditingController(text: widget.phoneNumber);
    _descriptionController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      widget.onUpdate(
        _nameController.text,
        _phoneController.text,
        _descriptionController.text,
      );
    }
  }


  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('삭제 확인'),
        content: const Text('정말로 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                var phoneNumber = widget.phoneNumber;
                widget.numberList.removeWhere((contact){
                  return contact.values.contains('$phoneNumber');
                });
              });
              Navigator.pop(context);
              widget.onDelete();
            },
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("편집"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _confirmDelete,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: '이름'),
                validator: (value) =>
                value!.isEmpty ? '이름을 입력하세요.' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: '전화번호'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                value!.isEmpty ? '전화번호를 입력하세요.' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: '메모'),
                validator: (value) =>
                value!.isEmpty ? '메모를 입력하세요.' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveChanges, // 저장 버튼
                child: const Text('저장'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
