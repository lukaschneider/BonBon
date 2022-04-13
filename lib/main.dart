import 'package:bonbon/common/theme.dart';
import 'package:bonbon/model/bon.dart';
import 'package:bonbon/pages/picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BonModel(),
      child: const BonBon(),
    ),
  );
}

class BonBon extends StatelessWidget {
  const BonBon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BonBon',
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const PickerPage(),
      },
    );
  }
}
