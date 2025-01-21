import 'package:flutter/material.dart';

/// Pro 页面
class ProPage extends StatefulWidget {
  const ProPage({Key? key}) : super(key: key);

  @override
  State<ProPage> createState() => _ProPageState();
}

class _ProPageState extends State<ProPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pro 版体验'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  '开源版不提供示例，请扫码下载 Pro 版体验',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Image.network(
              'https://flutterads.top/gzh_qrcode.webp',
              fit: BoxFit.cover,
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  '扫码关注公众号回复【Pro】，即可下载体验',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
