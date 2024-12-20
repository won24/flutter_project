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
                  Navigator.pop(context, 'deleted');
                } else if (result is Map<String, String>) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('수정되었습니다.')),
                  );
                  Navigator.pop(context, result);
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
          const SizedBox(height: 20),
          const Icon(
            Icons.account_circle,
            size: 200,
            color: Colors.grey,
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconColumn(
                icon: Icons.messenger,
                label: "메세지",
                onTap: () async {
                  if (await canLaunchUrl(_smsUrl)) {
                    await launchUrl(_smsUrl);
                  } else {
                    throw 'Could not launch $_smsUrl';
                  }
                },
              ),
              _buildIconColumn(
                icon: Icons.call,
                label: "통화",
                onTap: () async {
                  if (await canLaunchUrl(_telUrl)) {
                    await launchUrl(_telUrl);
                  } else {
                    throw 'Could not launch $_telUrl';
                  }
                },
              ),
              _buildIconColumn(
                icon: Icons.video_camera_front_rounded,
                label: "FaceTime",
                onTap: () {

                },
              ),
              _buildIconColumn(
                icon: Icons.mail,
                label: "Mail",
                onTap: () {

                },
              ),
            ],
          ),
          const SizedBox(height: 30),
          Column(
            children: [
              _buildDetailTile("전화번호", phone),
              _buildDetailTile("설명", description),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconColumn(
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return Column(
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon, size: 30),
          color: Colors.blue,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildDetailTile(String title, String subtitle) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
    );
  }
}