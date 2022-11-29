import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyLink extends StatelessWidget {
  const PrivacyLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse(
        'https://dolphin-pc.notion.site/edcda6e83c354e928a4283bea17f575e');

    return ElevatedButton(
      child: const Text('링크 열기'),
      onPressed: () {
        launchUrl(url);
      },
    );
  }
}
