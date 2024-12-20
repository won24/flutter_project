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

  // 전화번호 List
  List<Map<int, String>> numberList = [];

  @override
  void initState() {
    super.initState();
    ExternalNumberList externalNumberList = ExternalNumberList();
    numberList = externalNumberList.numberList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("전화번호부"),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddNumber(numberList: numberList),
                ),
              );
            },
            icon: Icon(Icons.add), // 더하기(+) 버튼
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: numberList.length,
        itemBuilder: (context, i){
          // 전화번호 리스트를 쪼개 담는 List
          dynamic numberMap = numberList[i];
          print(numberMap); // 일단 인덱스로 접근
          print(numberMap[++i]); // 1+i로 키에 접근
          List<String> parts = numberMap[i].toString().split(", "); // 바로 윗 줄에서 +1 증가된 i
          print(parts); // 배열화된 정보
          return ListTile(
            title: Text(parts[0]), // 이름
            subtitle: Text(parts[1]), // 번호
            trailing: Text(parts[2]), // 설명
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailWidget(numberList:numberList, name: parts[0], phone: parts[1], description: parts[2]), // 상세 내용
                  )
              );
            },
          );
        },
      ),


    );
  }
}

