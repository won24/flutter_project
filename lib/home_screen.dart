import 'package:flutter/material.dart';
import 'package:project/number_list.dart';
import 'package:project/widgets/add_number_widget.dart';
import '../widgets/detail_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<int, String>> numberList = [];

  @override
  void initState() {
    super.initState();
    ExternalNumberList externalNumberList = ExternalNumberList();
    numberList = externalNumberList.numberList;
  }

  void _navigateToAddNumber() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNumber(numberList: numberList),
      ),
    );

    if (result != null) {
      setState(() {
        numberList = List<Map<int, String>>.from(result); // 리스트 갱신
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("전화번호부"),
        actions: [
          IconButton(
            onPressed: _navigateToAddNumber,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: numberList.length,
        itemBuilder: (context, i) {
          final numberMap = numberList[i];
          final parts = numberMap.values.first.split(", ");
          return ListTile(
            title: Text(parts[0]),
            subtitle: Text(parts[1]),
            trailing: Text(parts[2]),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailWidget(
                    numberList: numberList,
                    name: parts[0],
                    phone: parts[1],
                    description: parts[2],
                  ),
                ),
              );

              if (result == 'deleted') {
                setState(() {
                  numberList.removeAt(i);
                });
              } else if (result is Map<String, String>) {
                setState(() {
                  numberList[i] = {
                    i + 1: '${result['name']}, ${result['phone']}, ${result['description']}'
                  };
                });
              }
            },
          );
        },
      ),
    );
  }
}