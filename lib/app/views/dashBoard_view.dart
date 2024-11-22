import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashBoard_controller.dart';

class DashBoardView extends GetView<DashBoardController> {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoardView'),
        centerTitle: true,
        backgroundColor: Colors.lime,
        toolbarHeight: 100.0,
      ),
    );
  }
}
