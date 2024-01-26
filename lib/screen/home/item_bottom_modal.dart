import 'package:flutter/material.dart';

class ItemBottomModal extends StatefulWidget {
  const ItemBottomModal({super.key});

  @override
  State<ItemBottomModal> createState() {
    return _ItemBottomModalScreen();
  }
}

class _ItemBottomModalScreen extends State<ItemBottomModal> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [Text('Will be update')],
    );
  }
}
