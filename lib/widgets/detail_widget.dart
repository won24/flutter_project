import 'package:flutter/material.dart';
import 'package:project/widgets/update_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailWidget extends StatelessWidget {
  final List<Map<int, String>> numberList;
  final String name;
  final String phone;
  final String description;

  const DetailWidget({
    super.key,
    required this.name,
    required this.phone,
    required this.description,
    required this.numberList,
  });

  Uri get _telUrl => Uri.parse('tel:+82-$phone');
  Uri get _smsUrl => Uri.parse('sms:$phone');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateWidget(
                      numberList: numberList,
                      name: name,
                      phoneNumber: phone,
                      description: description,
                      onDelete: () {
                        Navigator.pop(context, 'deleted');
                      },
                      onUpdate: (updatedName, updatedPhone, updatedDescription) {
                        Navigator.pop(context, {
                          'name': updatedName,
                          'phone': updatedPhone,
                          'description': updatedDescription,
                        });
                      },
                    ),
                  ),
                ).then((result) {
                  if (result == 'deleted') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('삭제되었습니다.')),
                    );
                    Navigator.pop(context); // DetailWidget 닫기
                  } else if (result is Map<String, String>) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('수정되었습니다.')),
                    );
                  }
                });
              },
              child: const Text(
                "편집",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      body: Column(
        children: [
          Icon(Icons.account_circle, size: 200,),
          Text(name),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () async {
                      if (await canLaunchUrl(_smsUrl)) {
                        await launchUrl(_smsUrl);
                      } else {
                        throw 'Could not launch $_smsUrl';
                      }
                    },
                    icon: Icon(Icons.messenger),
                  ),
                  Text("메세지"),
                ],
              ),
              Column(
                  children: [
                    IconButton(
                      onPressed: () async {
                        if (await canLaunchUrl(_telUrl)) {
                          await launchUrl(_telUrl);
                        } else {
                          throw 'Could not launch $_telUrl';
                        }
                      },
                      icon: Icon(Icons.call),
                    ),
                    Text("통화"),
                  ]
              ),
              Column(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.video_camera_front_rounded)),
                    Text("FaceTime"),
                  ]
              ),
              Column(
                  children: [
                      IconButton(onPressed: (){}, icon:Icon(Icons.mail)),
                      Text("mail"),
                  ]
              ),
            ]
          ),

          Column(
            children: [

              ListTile(
                subtitle: Text("전화번호"),
                title: Text(phone),
              ),
              ListTile(
                subtitle: Text("설명"),
                title: Text(description),
              ),
            ],
        )
        ],
      )
    );
  }
}
